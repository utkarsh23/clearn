package cmd

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"strings"

	"github.com/fatih/color"
	"github.com/fsnotify/fsnotify"
	"github.com/spf13/cobra"
)

type ExerciseStatus int64

const (
	Succeeded ExerciseStatus = iota
	Failed
)

type Exercise struct {
	Name            string `json:"name"`
	Path            string `json:"path"`
	HasTests        bool   `json:"hasTests"`
	CompilationHint string `json:"compilationHint"`
	Tests           []struct {
		Name string `json:"name"`
		Hint string `json:"hint"`
	} `json:"tests"`
}

type ExerciseList struct {
	Exercises []*Exercise `json:"exercises"`
}

func extractExercises() ([]*Exercise, error) {
	exercisesFile, err := os.Open("exercises/exercises.json")
	if err != nil {
		return nil, err
	}

	defer exercisesFile.Close()

	var exerciseList ExerciseList
	bytes, err := ioutil.ReadAll(exercisesFile)
	if err != nil {
		return nil, err
	}
	err = json.Unmarshal(bytes, &exerciseList)
	if err != nil {
		return nil, err
	}

	return exerciseList.Exercises, nil
}

func clearScreen() {
	fmt.Print("\033[H\033[2J")
}

func executeExercise(ex *Exercise) error {
	cmd := exec.Command("clarinet", "check")
	cmd.Dir = ex.Path
	cmd.Env = []string{"CLARINET_DISABLE_HINTS=1"}
	_, err := cmd.Output()
	if err != nil {
		clarFilePath := ex.Path
		clarFileName := clarFilePath[strings.LastIndex(clarFilePath, "/")+1:]
		color.Red("❌ Compilation Failed — %s\n\n", ex.Name)
		color.Blue("📂 Fix the file: %s/contracts/%s.clar\n\n", clarFilePath, clarFileName)
		color.Yellow("💡 Help:\n   %s", ex.CompilationHint)
		return err
	}
	color.Green("✅ Successfully compiled — %s", ex.Name)
	return nil
}

func executeTests(ex *Exercise) error {
	color.Cyan("🧪 Running tests for %s", ex.Name)
	cmd := exec.Command("clarinet", "test")
	cmd.Dir = ex.Path
	cmd.Env = []string{"CLARINET_DISABLE_HINTS=1"}
	testResults, err := cmd.Output()
	fmt.Println(string(testResults))
	if err != nil {
		clarFilePath := ex.Path
		clarFileName := clarFilePath[strings.LastIndex(clarFilePath, "/")+1:]
		color.Red("❌ Some or all tests Failed — %s\n\n", ex.Name)
		color.Blue("📂 Fix the file: %s/contracts/%s.clar\n\n", clarFilePath, clarFileName)
		color.Yellow("💡 Help:")
		for ind, test := range ex.Tests {
			color.Yellow("\n  Test #%d: %s\n  %s", ind+1, test.Name, test.Hint)
		}
		return err
	}
	color.Green("✅ All tests succeeded — %s", ex.Name)
	return nil
}

func fileWatcher(complete chan ExerciseStatus, watcher *fsnotify.Watcher, ex *Exercise) {
	for {
		select {
		case event, ok := <-watcher.Events:
			if !ok {
				complete <- Failed
				return
			}
			if event.Op&fsnotify.Write == fsnotify.Write {
				clearScreen()
				err := executeExercise(ex)
				if err == nil {
					if ex.HasTests {
						err := executeTests(ex)
						if err == nil {
							complete <- Succeeded
							return
						}
					} else {
						complete <- Succeeded
						return
					}
				}
			}
		case _, ok := <-watcher.Errors:
			if !ok {
				complete <- Failed
				return
			}
		}
	}
}

func watch(cmd *cobra.Command, args []string) {
	exercises, err := extractExercises()
	if err != nil {
		fmt.Println("Failed to parse exercises file", err)
		os.Exit(1)
	}

	for _, ex := range exercises {

		err := executeExercise(ex)
		if err == nil {
			if ex.HasTests {
				err := executeTests(ex)
				if err == nil {
					continue
				}
			} else {
				continue
			}
		}

		complete := make(chan ExerciseStatus)

		watcher, err := fsnotify.NewWatcher()
		if err != nil {
			log.Fatal("NewWatcher failed: ", err)
		}

		go fileWatcher(complete, watcher, ex)

		err = watcher.Add(fmt.Sprintf("%s/contracts", ex.Path))
		if err != nil {
			log.Fatal(err)
		}

		var exerciseStatus ExerciseStatus
		exerciseStatus, ok := <-complete
		if !ok {
			fmt.Println("Failure reading channel msg")
			os.Exit(1)
		}

		watcher.Close()

		if exerciseStatus == Failed {
			fmt.Println("Failure occured in exercise watch and execute", err)
			os.Exit(1)
		}
	}
}

var WatchCmd = &cobra.Command{
	Use:   "watch",
	Short: "executes the exercise in a predefined sequence",
	Long:  "executes the exercise in a predefined sequence",
	Run: func(cmd *cobra.Command, args []string) {
		watch(cmd, args)
	},
}

func init() {
	rootCmd.AddCommand(WatchCmd)
}

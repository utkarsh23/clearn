package cmd

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"

	"github.com/fsnotify/fsnotify"
	"github.com/spf13/cobra"
)

type ExerciseStatus int64

const (
	Succeeded ExerciseStatus = iota
	Failed
)

type Exercise struct {
	Name string `json:"name"`
	Path string `json:"path"`
	Hint string `json:"hint"`
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

func executeExercise(ex *Exercise) error {
	cmd := exec.Command("clarinet", "check")
	cmd.Dir = ex.Path
	cmd.Env = []string{"CLARINET_DISABLE_HINTS=1"}
	out, err := cmd.Output()
	if err != nil {
		fmt.Println("Hint: ", ex.Hint)
		fmt.Printf("Failed to run %s with error: %s\n", ex.Name, err.Error())
		return err
	}
	fmt.Println(string(out))
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
				err := executeExercise(ex)
				if err == nil {
					log.Println("Compiled successfully")
					complete <- Succeeded
					return
				}
			}
		case err, ok := <-watcher.Errors:
			if !ok {
				complete <- Failed
				return
			}
			log.Println("error:", err)
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
			continue
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
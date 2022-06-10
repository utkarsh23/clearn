package cmd

import (
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "clearn",
	Short: "Command Line Tool to manage learn clarity",
	Long:  "Command Line Tool to manage learn clarity",
}

func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

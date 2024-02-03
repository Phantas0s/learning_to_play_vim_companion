// The project is structured as follow:

// main.go (this file) - entry point
// pocket.go - interface to pocket third party API
// tui.go - interface to TUI third party library

// internal/platform/api.go - pocket API requests
// internal/platform/auth.go - pocket API Auth
// internal/platform/add.go - pocket API to add an entry
// internal/platform/modify.go - pocket API to modify an entry
// internal/platform/retrieve.go - pocket API to retrieve entries
// internal/platform/tview.go - Create TUI with tcell

package main

import (
	"github.com/Phantas0s/gocket/cmd"
)

func main() {
	cmd.Execute()
}

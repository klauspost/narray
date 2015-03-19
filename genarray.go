// Copyright (c) 2015 AKUALAB INC., All rights reserved.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build ignore

// Generate math file using "go run genarray.go"
package main

import (
	"bufio"
	"bytes"
	"fmt"
	"go/format"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"regexp"
	"runtime"
	"strings"
)

const outputName = "math_gen.go"

// Match lines with pattern: "func Log(x float64) float64"
var re = regexp.MustCompile("^func ([A-Z][[:alnum:]]*)[(][[:alnum:]]+ float64[)] float64")

func main() {

	var g Generator
	names := names()
	fmt.Printf("Generating %d narray functions:\n%s\n", len(names), names)

	g.Printf("// generated by narray; DO NOT EDIT\n")
	g.Printf("// more info at github.com/akualab/narray\n")
	g.Printf("\n")
	g.Printf("package narray\n\n")
	g.Printf("import \"math\"\n\n")

	for _, name := range names {

		g.Printf("// %s applies math.%s() elementwise to a multidimensional array.\n", name, name)
		g.Printf("// See math package in standard lib for details.\n")
		g.Printf("func %s(out, in *NArray) *NArray {\n", name)
		g.Printf("	if out == nil {\n")
		g.Printf("		out = New(in.Shape...)\n")
		g.Printf("	}\n")
		g.Printf("	for k,v := range in.Data {\n")
		g.Printf("		out.Data[k] = math.%s(v)\n", name)
		g.Printf("	}\n")
		g.Printf("	return out\n")
		g.Printf("}\n")
		g.Printf("\n")
	}

	// Format the output.
	src := g.format()

	// Write to file.
	err := ioutil.WriteFile(outputName, src, 0644)
	if err != nil {
		log.Fatalf("writing output: %s", err)
	}
}

// Get list of function names.
func names() []string {

	var names []string
	for _, path := range goFiles() {

		f, err := os.Open(path)
		if err != nil {
			panic(err)
		}
		scanner := bufio.NewScanner(f)
		for scanner.Scan() {
			line := scanner.Text()
			name, ok := f2f(line)
			if ok {
				names = append(names, name)
			}
		}
		if err := scanner.Err(); err != nil {
			fmt.Fprintf(os.Stderr, "error reading file [%s]: %s", path, err)
		}
		err = f.Close()
		if err != nil {
			panic(err)
		}
	}
	return names
}

// Get list of Go files to analyze.
func goFiles() []string {

	mathDir := filepath.Join(runtime.GOROOT(), "src", "math")
	var files []string
	err := filepath.Walk(mathDir, func(path string, info os.FileInfo, err error) error {

		if err != nil {
			return err
		}
		if info.IsDir() {
			return nil
		}

		if strings.HasSuffix(path, "_test.go") {
			return nil
		}

		if strings.HasSuffix(path, ".go") {
			files = append(files, path)
		}
		return nil
	})

	if err != nil {
		panic(err)
	}
	return files
}

// Returns a function name if it has the re pattern.
func f2f(line string) (string, bool) {

	result := re.FindStringSubmatch(line)
	if len(result) == 2 {
		return result[1], true
	}
	return "", false
}

// Generator holds the state of the analysis. Primarily used to buffer
// the output for format.Source.
type Generator struct {
	buf bytes.Buffer // Accumulated output.
}

func (g *Generator) Printf(format string, args ...interface{}) {
	fmt.Fprintf(&g.buf, format, args...)
}

// format returns the gofmt-ed contents of the Generator's buffer.
func (g *Generator) format() []byte {
	src, err := format.Source(g.buf.Bytes())
	if err != nil {
		// Should never happen, but can arise when developing this code.
		// The user can compile the output to see the error.
		log.Printf("warning: internal error: invalid Go generated: %s", err)
		log.Printf("warning: compile the package to analyze the error")
		return g.buf.Bytes()
	}
	return src
}

package main

import (
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"io/ioutil"
	"os"
)

var m map[string][]string

func checkDir(dir string) {
	files, err := ioutil.ReadDir(dir)
	if err == nil {
		for _, file := range files {
			path := dir + "/" + file.Name()
			if file.IsDir() {
				checkDir(path)
			} else {
				hash := sha256.New()
				data, err := ioutil.ReadFile(path)
				if err == nil {
					hash.Write(data)
					key := hex.EncodeToString(hash.Sum(nil))
					m[key] = append(m[key], path)
				}
			}
		}
	}
}

func printResult() {
	for _, v := range m {
		if len(v) > 1 {
			fmt.Println("-----------------")
			fmt.Printf("%v identical files found:\n", len(v))
			for _, file := range v {
				fmt.Println(file)
			}
		}
	}
	fmt.Println("-----------------\nDone")
}

func main() {
	m = make(map[string][]string)
	root := os.Args[1]
	fmt.Println("Checking duplicated files under", root)

	checkDir(root)
	printResult()
}

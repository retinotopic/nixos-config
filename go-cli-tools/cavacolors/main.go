package main

import (
	"bytes"
	"encoding/binary"
	"errors"
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"
	"os/signal"
	"path/filepath"
	"sync"
	"syscall"
)

type Chunk[T uint8 | uint16] struct {
	src       io.ReadCloser
	chunktype T
	buf       *bytes.Buffer
}

func (c *Chunk[T]) ProcessChunks(lngth int) error {
	if lngth < 1 {
		return errors.New("there should be more than 0 bars")
	}
	chunk := make([]T, lngth)
	denom := 0
	switch any(chunk[0]).(type) {
	case uint16:
		denom = 65536
	case uint8:
		denom = 256
	}
	for {
		err := binary.Read(c.src, binary.BigEndian, chunk)
		if err != nil {
			return err
		}
		c.buf.Reset()
		c.buf.WriteString(strbuf[0])
		for i := range len(chunk) {
			symidx := int(chunk[i]) * len(SYMBOLS) / denom
			if symidx > len(SYMBOLS) {
				symidx = len(SYMBOLS) - 1
			}
			clridx := int(chunk[i]) * len(COLORS) / denom
			if clridx > len(COLORS) {
				clridx = len(COLORS) - 1
			}
			c.buf.WriteString(strbuf[1])
			c.buf.WriteString(COLORS[clridx])
			c.buf.WriteString(strbuf[3])
			c.buf.WriteString(SYMBOLS[symidx])
			c.buf.WriteString(strbuf[5])
		}
		c.buf.WriteString(strbuf[6])
		c.buf.WriteString("\n")
		c.buf.WriteTo(os.Stdout)
	}
}

var strbuf = []string{`{"text":"`, "<span foreground='#", "DUMMY_COLOR",
	"'>", "DUMMY_SYMBOL", "</span>", `"}`}

// string.format('{"text":"%s"}\n', text))
func main() {
	buf := bytes.NewBuffer([]byte{})
	// ok := ConsiderExec()
	// if !ok {
	// 	buf.WriteString("🌱")
	// 	buf.WriteTo(os.Stdout)
	// 	return
	// }
	var err error
	var cmd *exec.Cmd
	var f *os.File
	var src io.ReadCloser
	sigch := make(chan os.Signal, 1)

	var wg sync.WaitGroup
	wg.Add(1)

	defer func() {
		if err != nil {
			log.Println(err)
		}
		sigch <- syscall.SIGTERM
		wg.Wait()
	}()

	go func() {
		<-sigch
		if cmd != nil {
			log.Println("waiting...")
			st, err := cmd.Process.Wait()

			log.Println(st.String(), err)
		}
		files, err := filepath.Glob("/tmp/cava*")
		if err == nil {
			for _, f := range files {
				if err := os.Remove(f); err != nil {
					log.Println(err)
					break
				}
			}
		} else {
			log.Println(err)
		}
		wg.Done()
	}()
	signal.Notify(sigch, syscall.SIGINT, syscall.SIGTERM,
		syscall.SIGQUIT, syscall.SIGHUP)

	f, err = os.CreateTemp("", "cava*")
	if err != nil {
		return
	}
	f.WriteString(config)

	cmd = exec.Command("cava", "-p", f.Name())
	src, err = cmd.StdoutPipe()
	if err != nil {
		return
	}
	err = cmd.Start()
	if err != nil {
		return
	}

	switch OUTPUT_BIT_FORMAT {
	case "16bit":
		chnk := Chunk[uint16]{src: src, buf: buf}
		err = chnk.ProcessChunks(BARS_NUMBER)
	case "8bit":
		chnk := Chunk[uint8]{src: src, buf: buf}
		err = chnk.ProcessChunks(BARS_NUMBER)
	}
	if err != nil {
		return
	}
}
func ConsiderExec() bool {
	flip, ok, state := "", false, os.Getenv("CAVA_STATE")
	switch state {
	case "true":
		flip = "false"
	case "false", "":
		flip = "true"
		ok = true
	}
	os.Setenv("CAVA_STATE", flip)
	return ok
}

const SENSITIVITY = "150"
const BARS_NUMBER = 12
const OUTPUT_BIT_FORMAT = "16bit"
const RAW_TARGET = "/dev/stdout"

var CONFIG_TPL = `
[general]
bars = %d
sensitivity = %s
[output]
method = raw
raw_target = %s
bit_format = %s`

var SYMBOLS = []string{"▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"}
var COLORS = []string{"d3c6aa", "7fbbb3", "d699b6", "e67e80",
	"e69875", "dbbc7f", "a7c080", "83c092"}

var config = fmt.Sprintf(CONFIG_TPL, BARS_NUMBER, SENSITIVITY,
	RAW_TARGET, OUTPUT_BIT_FORMAT)

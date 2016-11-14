package ps1

import (
	"errors"
	"io/ioutil"
	"math"
	"strconv"
	"strings"
)

func countPrimes(n int) int {
	count := 0
	for i := 2; i <= n; i++ {
		ok := true
		for j := 2; j < i; j++ {
			if i%j == 0 {
				ok = false
				break
			}
		}
		if ok {
			count++
		}
	}
	return count
}

func check_error(e error) {
	if e != nil {
		panic(e)
	}
}

func countStrings(filename string) map[string]int {
	data, err := ioutil.ReadFile(filename)
	check_error(err)

	str := string(data)

	str = strings.Replace(str, "\n", " ", -1)

	str2 := strings.Split(str, " ")

	m := make(map[string]int)

	for _, key := range str2 {
		m[key]++
	}

	delete(m, "")

	return m
}

type Time24 struct {
	hour, minute, second uint8
}

func validTime24(t Time24) bool {
	return t.hour < 24 && t.minute < 60 && t.second < 60
}

func equalsTime24(a, b Time24) bool {
	return a.hour == b.hour && a.minute == b.minute && a.second == b.second
}

func lessThanTime24(a, b Time24) bool {
	if a.hour < b.hour {
		return true
	}
	if a.hour > b.hour {
		return false
	}
	if a.minute < b.minute {
		return true
	}
	if a.minute > b.minute {
		return false
	}
	return a.second < b.second
}

func minTime24(times []Time24) (Time24, error) {
	var min Time24
	var err error
	if len(times) == 0 {
		err = errors.New("empty []Time24")
		return min, err
	}
	for i, t := range times {
		if i == 0 {
			min = t
		} else if lessThanTime24(t, min) {
			min = t
		}
	}
	return min, err
}

func (t Time24) String() string {
	var str string
	if t.hour < 10 {
		str += "0"
	}
	str += strconv.Itoa(int(t.hour)) + ":"
	if t.minute < 10 {
		str += "0"
	}
	str += strconv.Itoa(int(t.minute)) + ":"
	if t.second < 10 {
		str += "0"
	}
	str += strconv.Itoa(int(t.second))
	return str
}

func (t *Time24) AddOneHour() {
	t.hour++
	if t.hour > 23 {
		t.hour %= 24
	}
}

func allBitSeqs(n int) [][]int {
	if n <= 0 {
		return make([][]int, 0, 0)
	}
	l := int(math.Pow(float64(2), float64(n)))
	seq := make([][]int, 0, l)

	for i := 0; i < l; i++ {
		seq = append(seq, make([]int, n, n))
		q := i
		for j := len(seq[i]) - 1; j >= 0; j-- {
			seq[i][j] = q % 2
			if q == 0 {
				break
			}
			q /= 2
		}
	}

	return seq
}

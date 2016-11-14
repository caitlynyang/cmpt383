package ps1

import (
	"fmt"
	"testing"
)

func TestCountPrimes(t *testing.T) {
	expect := 1
	actual := countPrimes(2)
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}

	expect = 2
	actual = countPrimes(4)
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}

	expect = 1229
	actual = countPrimes(10000)
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}

	expect = 0
	actual = countPrimes(-6)
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}

	actual = countPrimes(0)
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}

	actual = countPrimes(1)
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}
}

func TestCountStrings(t *testing.T) {
	m := countStrings("strings.txt")

	fmt.Println(m)
	expect := 1
	actual := m["The"]
	if expect != actual {
		t.Error("string: \"The\", expect:", expect, ", actual:", actual)
	}

	actual = m["dog"]
	if expect != actual {
		t.Error("string: \"dog\", expect:", expect, ", actual:", actual)
	}

	actual = m["ate"]
	if expect != actual {
		t.Error("string: \"ate\", expect:", expect, ", actual:", actual)
	}

	actual = m["the"]
	if expect != actual {
		t.Error("string: \"the\", expect:", expect, ", actual:", actual)
	}

	actual = m["apple"]
	if expect != actual {
		t.Error("string: \"apple\", expect:", expect, ", actual:", actual)
	}

	expect = 3
	actual = m["big"]
	if expect != actual {
		t.Error("string: \"big\", expect:", expect, ", actual:", actual)
	}

	expect = 0
	actual = m["zero"]
	if expect != actual {
		t.Error("string: \"zero\", expect:", expect, ", actual:", actual)
	}
}

func TestValidTime24(t *testing.T) {
	time := Time24{hour: 24, minute: 0, second: 0}
	expect := false
	actual := validTime24(time)
	if expect != actual {
		t.Error("Time24(24:0:0), expect:", expect, ", actual:", actual)
	}

	time.hour = 23
	time.minute = 60
	actual = validTime24(time)
	if expect != actual {
		t.Error("Time24(23:60:0), expect:", expect, ", actual:", actual)
	}

	time.minute = 59
	time.second = 60
	actual = validTime24(time)
	if expect != actual {
		t.Error("Time24(23:59:60), expect:", expect, ", actual:", actual)
	}

	time.second = 59
	expect = true
	actual = validTime24(time)
	if expect != actual {
		t.Error("Time24(23:59:59), expect:", expect, ", actual:", actual)
	}
}

func TestEqualsTime24(t *testing.T) {
	time1 := Time24{hour: 23, minute: 0, second: 0}
	time2 := Time24{hour: 23, minute: 0, second: 0}
	expect := true
	actual := equalsTime24(time1, time2)
	if expect != actual {
		t.Error("a(23:0:0) b(23:0:0) expect:", expect, ", actual:", actual)
	}

	time2.hour = 0
	expect = false
	actual = equalsTime24(time1, time2)
	if expect != actual {
		t.Error("a(23:0:0) b(0:0:0) expect:", expect, ", actual:", actual)
	}

	time2.hour = 23
	time2.minute = 3
	actual = equalsTime24(time1, time2)
	if expect != actual {
		t.Error("a(23:0:0) b(23:3:0) expect:", expect, ", actual:", actual)
	}

	time2.minute = 0
	time2.second = 5
	actual = equalsTime24(time1, time2)
	if expect != actual {
		t.Error("a(23:0:0) b(23:0:5) expect:", expect, ", actual:", actual)
	}

	time2.hour = 5
	time2.minute = 5
	time2.second = 5
	actual = equalsTime24(time1, time2)
	if expect != actual {
		t.Error("a(23:0:0) b(5:5:5) expect:", expect, ", actual:", actual)
	}
}

func TestLessThanTime24(t *testing.T) {
	time1 := Time24{hour: 0, minute: 0, second: 0}
	time2 := Time24{hour: 22, minute: 50, second: 50}
	expect := true
	actual := lessThanTime24(time1, time2)
	if expect != actual {
		t.Error("a(0:0:0) b(22:50:50) expect:", expect, ", actual:", actual)
	}

	time1.hour = 22
	actual = lessThanTime24(time1, time2)
	if expect != actual {
		t.Error("a(22:0:0) b(22:50:50) expect:", expect, ", actual:", actual)
	}

	time1.minute = 50
	actual = lessThanTime24(time1, time2)
	if expect != actual {
		t.Error("a(22:50:0) b(22:50:50) expect:", expect, ", actual:", actual)
	}

	time1.second = 50
	expect = false
	actual = lessThanTime24(time1, time2)
	if expect != actual {
		t.Error("a(22:50:50) b(22:50:50) expect:", expect, ", actual:", actual)
	}

	time1.second = 55
	actual = lessThanTime24(time1, time2)
	if expect != actual {
		t.Error("a(22:50:55) b(22:50:50) expect:", expect, ", actual:", actual)
	}

	time1.hour = 23
	time1.minute = 0
	time1.second = 0
	actual = lessThanTime24(time1, time2)
	if expect != actual {
		t.Error("a(23:0:0) b(22:50:50) expect:", expect, ", actual:", actual)
	}

	time1.hour = 22
	time1.minute = 55
	actual = lessThanTime24(time1, time2)
	if expect != actual {
		t.Error("a(22:55:0) b(22:50:50) expect:", expect, ", actual:", actual)
	}
}

func TestMinTime24(t *testing.T) {
	times := make([]Time24, 3, 3)
	times[0].hour = 22
	times[1].hour = 11
	times[2].hour = 20

	min, err := minTime24(times)
	if nil != err {
		t.Error("[22:0:0 11:0:0 20:0:0] expect error: nil, actual:", err)
	}
	if 11 != min.hour {
		t.Error("[22:0:0 11:0:0 20:0:0] expect min: 11, actual:", min.hour)
	}

	empty := []Time24{}
	min, err = minTime24(empty)
	if nil == err {
		t.Error("[] expect some error, actual: nil")
	}
	if 0 != min.hour || 0 != min.minute || 0 != min.second {
		t.Error("[] expect min: 0:0:0, actual:", min.hour, ":", min.minute, ":", min.second)
	}
}

func TestTime24String(t *testing.T) {
	time := Time24{hour: 23, minute: 59, second: 59}

	expect := "23:59:59"
	actual := time.String()
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}

	time.hour = 3
	expect = "03:59:59"
	actual = time.String()
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}

	time.minute = 5
	expect = "03:05:59"
	actual = time.String()
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}

	time.second = 8
	expect = "03:05:08"
	actual = time.String()
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}
}

func TestTime24AddOneHour(t *testing.T) {
	time := Time24{hour: 22, minute: 59, second: 59}

	time.AddOneHour()
	expect := "23:59:59"
	actual := time.String()
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}

	time.AddOneHour()
	expect = "00:59:59"
	actual = time.String()
	if expect != actual {
		t.Error("expect:", expect, ", actual:", actual)
	}
}

func isBitSeq(seq []int) bool {
	for _, b := range seq {
		if !(b == 0 || b == 1) {
			return false
		}
	}
	return true
}

func TestAllBitSeqs(t *testing.T) {
	seq := allBitSeqs(3)
	fmt.Println(seq)
	if len(seq) != 8 {
		t.Error("allBitSeqs(3) expect len: 8, actual:", len(seq))
	}
	for i, item := range seq {
		if len(item) != 3 {
			t.Error("allBitSeqs(3) expect bits: 3, actual:", len(item))
		}
		if !isBitSeq(item) {
			t.Error("allBitSeqs(3) contains non-bit value at index ", i)
		}
	}

	seq = allBitSeqs(2)
	fmt.Println(seq)
	if len(seq) != 4 {
		t.Error("allBitSeqs(2) expect len: 4, actual:", len(seq))
	}
	for i, item := range seq {
		if len(item) != 2 {
			t.Error("allBitSeqs(2) expect bits: 2, actual:", len(item))
		}
		if !isBitSeq(item) {
			t.Error("allBitSeqs(2) contains non-bit value at index ", i)
		}
	}

	seq = allBitSeqs(1)
	fmt.Println(seq)
	if len(seq) != 2 {
		t.Error("allBitSeqs(1) expect len: 2, actual:", len(seq))
	}
	for i, item := range seq {
		if len(item) != 1 {
			t.Error("allBitSeqs(1) expect bits: 1, actual:", len(item))
		}
		if !isBitSeq(item) {
			t.Error("allBitSeqs(1) contains non-bit value at index ", i)
		}
	}

	seq = allBitSeqs(0)
	fmt.Println(seq)
	if len(seq) != 0 {
		t.Error("allBitSeqs(0) expect len: 0, actual:", len(seq))
	}

	seq = allBitSeqs(-1)
	fmt.Println(seq)
	if len(seq) != 0 {
		t.Error("allBitSeqs(-1) expect len: 0, actual:", len(seq))
	}
}

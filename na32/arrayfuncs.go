// generated by narray; DO NOT EDIT

// +build !amd64

package na32

import (
	"math"
)

// These are the fallbacks that are used when not on AMD64 platform.

// divSlice divides two slices
// Assumptions the assembly can make:
// out != nil, a != nil, b != nil
// len(out)  == len(a) == len(b)
func divSlice(out, a, b []float32) {
	for i := 0; i < len(out); i++ {
		out[i] = a[i] / b[i]
	}
}

// addSlice adds two slices
// Assumptions the assembly can make:
// out != nil, a != nil, b != nil
// len(out)  == len(a) == len(b)
func addSlice(out, a, b []float32) {
	for i := 0; i < len(out); i++ {
		out[i] = a[i] + b[i]
	}
}

// subSlice subtracts two slices
// Assumptions the assembly can make:
// out != nil, a != nil, b != nil
// len(out)  == len(a) == len(b)
func subSlice(out, a, b []float32) {
	for i := 0; i < len(out); i++ {
		out[i] = a[i] - b[i]
	}
}

// mulSlice multiply two slices
// Assumptions the assembly can make:
// out != nil, a != nil, b != nil
// len(out)  == len(a) == len(b)
func mulSlice(out, a, b []float32) {
	for i := 0; i < len(out); i++ {
		out[i] = a[i] * b[i]
	}
}

// minSlice returns lowest valus of two slices
// Assumptions the assembly can make:
// out != nil, a != nil, b != nil
// len(out)  == len(a) == len(b)
func minSlice(out, a, b []float32) {
	for i := 0; i < len(out); i++ {
		if a[i] < b[i] {
			out[i] = a[i]
		} else {
			out[i] = b[i]
		}
	}
}

// maxSlice return maximum of two slices
// Assumptions the assembly can make:
// out != nil, a != nil, b != nil
// len(out)  == len(a) == len(b)
func maxSlice(out, a, b []float32) {
	for i := 0; i < len(out); i++ {
		if a[i] > b[i] {
			out[i] = a[i]
		} else {
			out[i] = b[i]
		}
	}
}

// csignSlice returns a value with the magnitude of a and the sign of b
// for each element in the slice.
// Assumptions the assembly can make:
// out != nil, a != nil, b != nil
// len(out)  == len(a) == len(b)
func csignSlice(out, a, b []float32) {
	const sign = 1 << 31
	for i := 0; i < len(out); i++ {

		out[i] = math.Float32frombits(math.Float32bits(a[i])&^sign | math.Float32bits(b[i])&sign)
	}
}

// cdivSlice will return c / values of the array
// Assumptions the assembly can make:
// out != nil, a != nil
// len(out)  == len(a)
func cdivSlice(out, a []float32, c float32) {
	for i := 0; i < len(out); i++ {
		out[i] = c / a[i]
	}
}

// cmulSlice will return c * values of the array
// Assumptions the assembly can make:
// out != nil, a != nil
// len(out)  == len(a)
func cmulSlice(out, a []float32, c float32) {
	for i := 0; i < len(out); i++ {
		out[i] = c * a[i]
	}
}

// caddSlice will return c * values of the array
// Assumptions the assembly can make:
// out != nil, a != nil
// len(out)  == len(a)
func caddSlice(out, a []float32, c float32) {
	for i := 0; i < len(out); i++ {
		out[i] = c + a[i]
	}
}

// addScaledSlice adds a scaled narray elementwise.
// y = y + a * x
// Assumptions the assembly can make:
// y != nil, a != nil
// len(x)  == len(y)
func addScaledSlice(y, x []float32, a float32) {
	for i, v := range x {
		y[i] += v * a
	}
}

// sqrtSlice will return math.Sqrt(values) of the array
// Assumptions the assembly can make:
// out != nil, a != nil
// len(out)  == len(a)
func sqrtSlice(out, a []float32) {
	for i := 0; i < len(out); i++ {
		out[i] = float32(math.Sqrt(float64(a[i])))
	}
}

// minSliceElement will the smallest value of the slice
// Assumptions the assembly can make:
// a != nil
// len(a) > 0
func minSliceElement(a []float32) float32 {
	min := a[0]
	for i := 1; i < len(a); i++ {
		if a[i] < min {
			min = a[i]
		}
	}
	return min
}

// maxSliceElement will the biggest value of the slice
// Assumptions the assembly can make:
// a != nil
// len(a) > 0
func maxSliceElement(a []float32) float32 {
	max := a[0]
	for i := 1; i < len(a); i++ {
		if a[i] > max {
			max = a[i]
		}
	}
	return max
}

// sliceSum will return the sum of all elements of the slice
// Assumptions the assembly can make:
// a != nil
// len(a) >= 0
func sliceSum(a []float32) float32 {
	sum := float32(0.0)
	for _, v := range a {
		sum += v
	}
	return sum
}

// absSlice will return math.Abs(values) of the array
// Assumptions the assembly can make:
// out != nil, a != nil
// len(out)  == len(a)
func absSlice(out, a []float32) {
	for i, v := range a {
		out[i] = float32(math.Abs(float64(v)))
	}
}

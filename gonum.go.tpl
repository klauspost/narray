// Copyright (c) 2015 AKUALAB INC., All rights reserved.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package {{.Package}}

// Matrix is as an NArray of rank 2 that satisfies the gonum Matrix interfaces.
type Matrix NArray

// Vector is as an NArray of rank 1 that satisfies the gonum Vectorer interface.
type Vector NArray

// Matrix creates a subarray of rank 2.
// Equivalent to SubArray but restricted to the case where the
// resulting subarray has rank=2. (It will panic otherwise.)
// See SubArray for details.
func (na *NArray) Matrix(query ...int) *Matrix {

	mat := na.SubArray(query...)
	if len(mat.Shape) != 2 {
		panic("matrix must have rank equal two")
	}
	return (*Matrix)(mat)
}

// Dims returns the dimensions of a Matrix.
func (mat *Matrix) Dims() (r, c int) {
	na := (*NArray)(mat)
	return na.Shape[0], na.Shape[1]
}

// At returns the value of a matrix element at (r, c). It will panic if r or c are
// out of bounds for the matrix.
func (mat *Matrix) At(r, c int) {{.Format}} {
	na := (*NArray)(mat)
	return na.At(r, c)
}

// Set alters the matrix element at (r, c) to v. It will panic if r or c are out of
// bounds for the matrix.
func (mat *Matrix) Set(r, c int, v {{.Format}}) {
	na := (*NArray)(mat)
	na.Set(v, r, c)
}

// String returns vector as a printable string.
func (mat *Matrix) String() string {
	na := (*NArray)(mat)
	return na.String()
}

// Vector creates a subarray of rank 1.
// Equivalent to SubArray but restricted to the case where the
// resulting subarray has rank=1. (It will panic otherwise.)
// See SubArray for details.
//
// Example, given a 5x10 matrix (rank=2), return the vector
// of dim 10 for row idx=3:
//
//   x := New(5,10)
//   y := x.Vector(3,-1)
//   // y = {x_30, x_31, ... , x_39}
func (na *NArray) Vector(query ...int) *Vector {

	vec := na.SubArray(query...)
	if len(vec.Shape) != 1 {
		panic("vector must have rank equal one")
	}
	return (*Vector)(vec)
}

// Row returns a slice of {{.Format}} for the row specified. It will panic if the index
// is out of bounds. If the call requires a copy and dst is not nil it will be used and
// returned, if it is not nil the number of elements copied will be the minimum of the
// length of the slice and the number of columns in the matrix.
func (mat *Matrix) Row(dst []{{.Format}}, i int) []{{.Format}} {
	_, ncols := mat.Dims()
	if dst == nil {
		dst = make([]{{.Format}}, ncols, ncols)
	}
	for j, _ := range dst {
		dst[j] = mat.At(i, j)
	}
	return dst
}

// Col returns a slice of {{.Format}} for the column specified. It will panic if the index
// is out of bounds. If the call requires a copy and dst is not nil it will be used and
// returned, if it is not nil the number of elements copied will be the minimum of the
// length of the slice and the number of rows in the matrix.
func (mat *Matrix) Col(dst []{{.Format}}, j int) []{{.Format}} {
	nrows, _ := mat.Dims()
	if dst == nil {
		dst = make([]{{.Format}}, nrows, nrows)
	}
	for i, _ := range dst {
		dst[i] = mat.At(i, j)
	}
	return dst
}

// SetRow sets the values of the specified row to the values held in a slice of {{.Format}}.
// It will panic if the index is out of bounds. The number of elements copied is
// returned and will be the minimum of the length of the slice and the number of columns
// in the matrix.
func (mat *Matrix) SetRow(i int, src []{{.Format}}) int {

	numCopied := len(src)
	if len(src) > mat.Shape[1] {
		numCopied = mat.Shape[1]
	}
	for j := 0; j < numCopied; j++ {
		mat.Set(i, j, src[j])
	}
	return numCopied
}

// SetCol sets the values of the specified column to the values held in a slice of {{.Format}}.
// It will panic if the index is out of bounds. The number of elements copied is
// returned and will be the minimum of the length of the slice and the number of rows
// in the matrix.
func (mat *Matrix) SetCol(j int, src []{{.Format}}) int {

	numCopied := len(src)
	if len(src) > mat.Shape[0] {
		numCopied = mat.Shape[0]
	}
	for i := 0; i < numCopied; i++ {
		mat.Set(i, j, src[i])
	}
	return numCopied
}

// TODO finish implementing gonum interfaces.

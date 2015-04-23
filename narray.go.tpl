// Copyright (c) 2015 AKUALAB INC., All rights reserved.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/*
Package narray provides functions to opearate with multidimensional arrays of type {{.Format}}. The NArray object is a dense, fixed-size, array of rank n.

The shape is a vector with the size of each dimension. Typical cases:

  type      rank   example
  --------------------------------
  scalar    0      na := New()
  vector    1      na := New(12)
  matrix    2      na := New(5,17)
  cube      3      na := New(2,3,5)

*/
package {{.Package}}

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"math"
	"math/rand"
	"os"
	"path/filepath"
	"strconv"
)

// The NArray object.
type NArray struct {
	// The rank or order or degree of the narray is the dimensionality required to represent it. (eg. The rank of a vector is 1)
	Rank int `json:"rank"`
	// The shape is an int slice that contains the size of each dimension. Subscripts range from zero to s-1. Where s is the size of a dimension.
	Shape []int `json:"shape"`
	// The data is stored as a slice of {{.Format}} numbers.
	Data []{{.Format}} `json:"data"`
	// Strides for each dimension.
	Strides []int `json:"strides"`
}

// New creates a new n-dimensional array.
func New(shape ...int) *NArray {

	size := 1
	rank := len(shape)
	for _, v := range shape {
		size *= v
	}
	strides := make([]int, rank, rank)
	s := 1
	for i := (rank - 1); i >= 0; i-- {
		strides[i] = s
		s *= shape[i]
	}

	return &NArray{
		Rank:    rank,
		Shape:   shape,
		Data:    make([]{{.Format}}, size, size),
		Strides: strides,
	}
}

// NewArray creates a new n-dimensional array with content of a slice
// The size of the slice must match the product of the slice,
// otherwise a panic will occur
func NewArray(a []{{.Format}},shape ...int) *NArray {
	size := 1
	rank := len(shape)
	for _, v := range shape {
		size *= v
	}
	strides := make([]int, rank, rank)
	s := 1
	for i := (rank - 1); i >= 0; i-- {
		strides[i] = s
		s *= shape[i]
	}

	if len(a) != size {
		panic("slice doesn't match size")
	}
	return &NArray{
		Rank:    rank,
		Shape:   shape,
		Data:    a,
		Strides: strides,
	}
}

// Norm creates a new n-dimensional array whose
// elements are drawn from a Normal probability density function.
func Norm(r *rand.Rand, mean, sd {{.Format}}, shape ...int) *NArray {

	na := New(shape...)
	for i := range na.Data {
		na.Data[i] = {{.Format}}(r.NormFloat64())*sd + mean
	}
	return na
}

// Rand creates a new n-dimensional array whose
// elements are set using the rand.Float64 function.
// Values are pseudo-random numbers in [0.0,1.0).
func Rand(r *rand.Rand, shape ...int) *NArray {

	na := New(shape...)
	for i := range na.Data {
 {{if .Float64}}na.Data[i] = r.Float64(){{end}} {{if .Float32}}na.Data[i] = r.Float32(){{end}}
	}
	return na
}

// At returns the value for indices.
func (na *NArray) At(indices ...int) {{.Format}} {

	if len(indices) != na.Rank {
		fmt.Errorf("inconsistent number of indices for narray - [%d] vs [%d]", len(indices), na.Rank)
	}

	//	return na.Data[na.Index(indices...)]
	return na.Data[na.Index(indices...)]
}

// Set value for indices.
func (na *NArray) Set(v {{.Format}}, indices ...int) {

	na.Data[na.Index(indices...)] = v
}

// Index transforms a set of subscripts to a an index in the underlying one-dimensional slice.
func (na *NArray) Index(indices ...int) int {

	idx := 0
	for k, v := range indices {
		idx += v * na.Strides[k]
	}
	return idx
}

// ReverseIndex converts a linear index to narray indices.
func (na *NArray) ReverseIndex(idx int) []int {

	res := make([]int, na.Rank, na.Rank)
	temp := idx
	p := 1
	for k := 1; k < na.Rank; k++ {
		p *= na.Shape[k]
	}
	for i := 0; i < na.Rank; i++ {
		res[i] = temp / p
		temp = temp % p
		if (i + 1) < na.Rank {
			p /= na.Shape[i+1]
		}
	}
	return res
}

// Copy returns a copy on the narray.
func (na *NArray) Copy() *NArray {

	newna := New(na.Shape...)
	copy(newna.Data, na.Data)
	return newna
}

// ApplyFunc is a type for creating custom functions.
type ApplyFunc func(x {{.Format}}) {{.Format}}

// Apply function of type ApplyFunc to a multidimensional array.
// If out is nil, a new object is allocated.
func Apply(out, in *NArray, fn ApplyFunc) *NArray {

	if out == nil {
		out = New(in.Shape...)
	}
	for i := 0; i < len(in.Data); i++ {
		out.Data[i] = fn(in.Data[i])
	}
	return out
}

// EqualShape returns true if all the arrays have equal length,
// and false otherwise. Returns true if there is only one input array.
func EqualShape(x *NArray, ys ...*NArray) bool {
	shape := x.Shape
	l := len(shape)
	for _, y := range ys {
		if len(y.Shape) != l {
			return false
		}
		for j, d := range shape {
			if y.Shape[j] != d {
				return false
			}
		}
	}
	return true
}

// Inc increments the value of an narray element.
func (na *NArray) Inc(v {{.Format}}, indices ...int) {

	na.Data[na.Index(indices...)] += v
}

// MaxElem compares value to element and replaces element if
// value is greater than element.
func (na *NArray) MaxElem(v {{.Format}}, indices ...int) {

	idx := na.Index(indices...)
	if v > na.Data[idx] {
		na.Data[idx] = v
	}
}

// MinElem compares value to element and replaces element if
// value is less than element.
func (na *NArray) MinElem(v {{.Format}}, indices ...int) {

	idx := na.Index(indices...)
	if v < na.Data[idx] {
		na.Data[idx] = v
	}
}

// Add adds narrays elementwise.
//   out = sum_i(in[i])
// Will panic if there are not at least two input narrays
// or if narray shapes don't match.
// If out is nil a new array is created.
func Add(out *NArray, in ...*NArray) *NArray {

	if len(in) < 2 {
		return nil
	}
	if out == nil {
		out = New(in[0].Shape...)
	}
	if !EqualShape(out, in...) {
		panic("narrays must have equal shape.")
	}

	addSlice(out.Data, in[0].Data, in[1].Data)

	// Multiply each following, if more than two arguments.
	for k := 2; k < len(in); k++ {
		addSlice(out.Data, out.Data, in[k].Data)
	}

	return out
}

// Mul multiplies narrays elementwise.
//   out = prod_i(in[i])
// Will panic if there are not at least two input narrays
// or if narray shapes don't match.
// If out is nil a new array is created.
func Mul(out *NArray, in ...*NArray) *NArray {

	if len(in) < 2 {
		panic("not in enough arguments")
	}
	if out == nil {
		out = New(in[0].Shape...)
	}
	if !EqualShape(out, in...) {
		panic("narrays must have equal shape.")
	}

	mulSlice(out.Data, in[0].Data, in[1].Data)

	// Multiply each following, if more than two arguments.
	for k := 2; k < len(in); k++ {
		mulSlice(out.Data, out.Data, in[k].Data)
	}
	return out
}

// Dot computes the sum of the elementwise products of
// the input arrays.
//
//   y = sum_{i = 0}^(N-1) x0[i]*x1[i]*...x_n-1[i]
//
// Will panic if there are not at least two input narrays
// or if narray shapes don't match.
func Dot(in ...*NArray) float64 {

	if len(in) < 2 {
		panic("not in enough arguments")
	}
	if !EqualShape(in[0], in...) {
		panic("narrays must have equal shape.")
	}
    n:=len(in[0].Data)
	out := make([]float64,n,n)
	mulSlice(out, in[0].Data, in[1].Data)

	// Multiply each following, if more than two arguments.
	for k := 2; k < len(in); k++ {
		mulSlice(out, out, in[k].Data)
	}
	return sliceSum(out)
}

// Div divides narrays elementwise.
//   out = in[0] / in[1] / in[2] ....
// Will panic if there are not at least two input narrays
// or if narray shapes don't match.
// If out is nil a new array is created.
func Div(out *NArray, in ...*NArray) *NArray {

	if len(in) < 2 {
		panic("not in enough arguments")
	}
	if out == nil {
		out = New(in[0].Shape...)
	}
	if !EqualShape(out, in...) {
		panic("narrays must have equal shape.")
	}

	divSlice(out.Data, in[0].Data, in[1].Data)

	// Multiply each following, if more than two arguments.
	for k := 2; k < len(in); k++ {
		divSlice(out.Data, out.Data, in[k].Data)
	}
	return out
}

// Sub subtracts narrays elementwise.
//   out = in[0] - in[1] - in[2] ....
// Will panic if there are not at least two input narrays
// or if narray shapes don't match.
// If out is nil a new array is created.
func Sub(out *NArray, in ...*NArray) *NArray {

	if len(in) < 2 {
		panic("not in enough arguments")
	}
	if out == nil {
		out = New(in[0].Shape...)
	}
	if !EqualShape(out, in...) {
		panic("narrays must have equal shape.")
	}

	subSlice(out.Data, in[0].Data, in[1].Data)

	// Multiply each following, if more than two arguments.
	for k := 2; k < len(in); k++ {
		subSlice(out.Data, out.Data, in[k].Data)
	}
	return out
}

// AddConst adds const to an narray elementwise.
// out = in + c
// If out is nil a new array is created.
func AddConst(out *NArray, in *NArray, c {{.Format}}) *NArray {

	if out == nil {
		out = New(in.Shape...)
	} else {
		if !EqualShape(out, in) {
			panic("narrays must have equal shape.")
		}
	}
	caddSlice(out.Data, in.Data, c)
	return out
}

// AddScaled adds a scaled narray elementwise.
// y = y + a * x
// If y is nil a new array is created.
func AddScaled(y *NArray, x *NArray, a {{.Format}}) *NArray {

	if y == nil {
		y = New(x.Shape...)
	} else {
		if !EqualShape(y, x) {
			panic("narrays must have equal shape.")
		}
	}
	addScaledSlice(y.Data, x.Data, a)
	return y
}

// Scale multiplies an narray by a factor elementwise.
// out = c * in
// If out is nil a new array is created.
func Scale(out *NArray, in *NArray, c {{.Format}}) *NArray {

	if out == nil {
		out = New(in.Shape...)
	} else {
		if !EqualShape(out, in) {
			panic("narrays must have equal shape.")
		}
	}
	cmulSlice(out.Data, in.Data, c)
	return out
}

// Rcp returns reciprocal values of narrays elementwise.
// out = 1.0 / in
// If out is nil a new array is created.
func Rcp(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else {
		if !EqualShape(out, in) {
			panic("narrays must have equal shape.")
		}
	}
	cdivSlice(out.Data, in.Data, 1.0)
	return out
}

// Sqrt returns square root values of narrays elementwise.
// out = math.Sqrt(in)
// If out is nil a new array is created.
func Sqrt(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else {
		if !EqualShape(out, in) {
			panic("narrays must have equal shape.")
		}
	}
	sqrtSlice(out.Data, in.Data)
	return out
}

// Abs returns square root values of narrays elementwise.
// out = math.Abs(in)
// If out is nil a new array is created.
func Abs(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else {
		if !EqualShape(out, in) {
			panic("narrays must have equal shape.")
		}
	}
	absSlice(out.Data, in.Data)
	return out
}

// Max returns the max value in the narray.
func (na *NArray) Max() {{.Format}} {
	if na == nil || len(na.Data) == 0 {
		panic("unable to take max of nil or zero-sizes array")
	}
	return maxSliceElement(na.Data)
}

// MaxIdx returns the max value and corresponding indices.
func (na *NArray) MaxIdx() ({{.Format}}, []int) {

	var offset int
	max := {{.Smallest}}
	for i := 0; i < len(na.Data); i++ {
		if na.Data[i] > max {
			max = na.Data[i]
			offset = i
		}
	}
	return max, na.ReverseIndex(offset)
}

// MaxArray compare input narrays and returns an narray containing
// the element-wise maxima.
//   out[i,j,k,...] = max(in0[i,j,k,...], in1[i,j,k,...], ...)
// Will panic if there are not at least two input narray
// or if narray shapes don't match.
// If out is nil a new array is created.
func MaxArray(out *NArray, in ...*NArray) *NArray {

	if len(in) < 2 {
		panic("not in enough input narrays")
	}
	if out == nil {
		out = New(in[0].Shape...)
	}
	if !EqualShape(out, in...) {
		panic("narrays must have equal shape.")
	}

	maxSlice(out.Data, in[0].Data, in[1].Data)

	// Also add each following, if more than two arguments.
	for k := 2; k < len(in); k++ {
		maxSlice(out.Data, out.Data, in[k].Data)
	}
	return out
}

// Copysign returns values with the magnitude of a and the sign of b
// for each element of the arrays.
// Will panic if narray shapes don't match.
// If out is nil a new array is created.
func Copysign(out, a, b *NArray) *NArray {

	if out == nil {
		out = New(a.Shape...)
	}
	if !EqualShape(out, a, b) {
		panic("narrays must have equal shape.")
	}

	csignSlice(out.Data, a.Data, b.Data)

	return out
}

// Min returns the min value in the narray.
func (na *NArray) Min() {{.Format}} {
	if na == nil || len(na.Data) == 0 {
		panic("unable to take min of nil or zero-sizes array")
	}
	return minSliceElement(na.Data)
}

// MinIdx returns the min value and corresponding indices.
func (na *NArray) MinIdx() ({{.Format}}, []int) {

	var offset int
	min := {{.Biggest}}
	for i := 0; i < len(na.Data); i++ {
		if na.Data[i] < min {
			min = na.Data[i]
			offset = i
		}
	}
	return min, na.ReverseIndex(offset)
}

// MinArray compare input narrays and returns an narray containing
// the element-wise minima.
//   out[i,j,k,...] = min(in0[i,j,k,...], in1[i,j,k,...], ...)
// Will panic if there are not at least two input narray
// or if narray shapes don't match.
// If out is nil a new array is created.
func MinArray(out *NArray, in ...*NArray) *NArray {

	if len(in) < 2 {
		panic("not in enough input narrays")
	}
	if out == nil {
		out = New(in[0].Shape...)
	}
	if !EqualShape(out, in...) {
		panic("narrays must have equal shape.")
	}

	minSlice(out.Data, in[0].Data, in[1].Data)

	// Also add each following, if more than two arguments.
	for k := 2; k < len(in); k++ {
		minSlice(out.Data, out.Data, in[k].Data)
	}

	return out
}

// Prod returns the products of all the elements in the narray.
func (na *NArray) Prod() {{.Format}} {

	p := {{.Format}}(1.0)
	for _, v := range na.Data {
		p *= v
	}
	return p
}

// Sum returns the sum of all the elements in the narray.
func (na *NArray) Sum() {{.Format}} {
	return sliceSum(na.Data)
}

// SetValue sets all elements to value.
func (na *NArray) SetValue(v {{.Format}}) *NArray {

	for i := range na.Data {
		na.Data[i] = v
	}
	return na
}

// Encode converts values in-place as follows:
//   Inf to math.MaxFloat64
//   -Inf to -math.MaxFloat64
//   NaN ro 0
//
// Returns the indices of the modified values as follows:
//   Values in inf => na.Data[abs(v)] = sign(v) * Inf
//   Values in nan => na.Data[v] = NaN
func (na *NArray) Encode() (inf, nan []int) {

	inf = []int{}
	nan = []int{}
	for k, v := range na.Data {
		switch {
		case math.IsInf(float64(v), 1):
			na.Data[k] = {{.Biggest}}
			inf = append(inf, k)
		case math.IsInf(float64(v), -1):
			na.Data[k] = {{.Smallest}}
			inf = append(inf, -k)
		case math.IsNaN(float64(v)):
			na.Data[k] = 0
			nan = append(nan, k)
		}
	}
	return
}

// Decode converts values in-place.
// See Encode() for details.
func (na *NArray) Decode(inf, nan []int) {
	pInf := {{.Format}}(math.Inf(1))
	nInf := {{.Format}}(math.Inf(-1))
	fNan := {{.Format}}(math.NaN())

	for _, v := range inf {
		if v >= 0 {
			na.Data[v] = pInf
		} else {
			na.Data[-v] = nInf
		}
	}
	for _, v := range nan {
		na.Data[v] = fNan
	}
}

// SubArray returns an narray of lower rank as follows:
//
// Example, given an narray with shape 2x3x4 (rank=3), return the subarray
// of rank=2 corresponding to dim[2]=1
//
//   x := New(2,3,4)
//   y := x.SubArray(-1,-1,1) // use -1 to select a dimension. Put a 1 in dim=2 (third argument).
//   // y = {x(0,0,1), x(0,1,1), x(0,2,1), x(1,0,1), ...}
//
func (na *NArray) SubArray(query ...int) *NArray {

	if len(na.Shape) == 0 {
		panic("cannot get subarray from narray with rank=0")
	}

	qs := querySubset(query, na.Shape)
	var ns []int // new shape
	for k, v := range query {
		if v < 0 {
			ns = append(ns, na.Shape[k])
		}
	}
	newArr := New(ns...)
	for k, v := range qs {
		newArr.Data[k] = na.At(v...)
	}

	return newArr
}

// Reshape returns an narray with a new shape.
func (na *NArray) Reshape(dim ...int) *NArray {
	panic("not implemented")
}

// Sprint prints narray elements when f returns true.
// index is the linear index of an narray.
func (na *NArray) Sprint(f func(na *NArray, index int) bool) string {

	b := bytes.NewBufferString(fmt.Sprintln("narray rank:  ", na.Rank))
	_, _ = b.WriteString(fmt.Sprintln("narray shape: ", na.Shape))
	for k, v := range na.Data {
		idx := na.ReverseIndex(k)
		if f(na, k) {
			_, _ = b.WriteString("[")
			for axis, av := range idx {
				_, _ = b.WriteString(formatted(av, na.Shape[axis]-1))
			}
			_, _ = b.WriteString(fmt.Sprintf("] => %f\n", v))
		}
	}
	return b.String()
}

// Read unmarshals json data from an io.Reader into an narray struct.
func Read(r io.Reader) (*NArray, error) {
	dec := json.NewDecoder(r)
	var na NArray
	err := dec.Decode(&na)
	if err != nil && err != io.EOF {
		return nil, err
	}
	return &na, nil
}

// ReadFile unmarshals json data from a file into an narray struct.
func ReadFile(fn string) (*NArray, error) {

	f, err := os.Open(fn)
	if err != nil {
		return nil, err
	}
	defer f.Close()
	return Read(f)
}

// Write writes narray to an io.Writer.
func (na *NArray) Write(w io.Writer) error {

	enc := json.NewEncoder(w)
	err := enc.Encode(na)
	if err != nil {
		return err
	}
	return nil
}

// WriteFile writes an narray to a file.
func (na *NArray) WriteFile(fn string) error {

	e := os.MkdirAll(filepath.Dir(fn), 0755)
	if e != nil {
		return e
	}
	f, err := os.Create(fn)
	if err != nil {
		return err
	}
	defer f.Close()

	ee := na.Write(f)
	if ee != nil {
		return ee
	}
	return nil
}

// ToJSON returns a json string.
func (na *NArray) ToJSON() (string, error) {
	var b bytes.Buffer
	err := na.Write(&b)
	return b.String(), err
}

// MarshalJSON implements the json.Marshaller interface.
// The custom marshaller is needed to encode Inf/NaN values.
func (na *NArray) MarshalJSON() ([]byte, error) {

	ena := na.Copy()
	inf, nan := ena.Encode()
	return json.Marshal(struct {
		Rank    int       `json:"rank"`
		Shape   []int     `json:"shape"`
		Data    []{{.Format}} `json:"data"`
		Strides []int     `json:"strides"`
		Inf     []int     `json:"inf,omitempty"`
		NaN     []int     `json:"nan,omitempty"`
	}{
		Rank:    ena.Rank,
		Shape:   ena.Shape,
		Data:    ena.Data,
		Strides: ena.Strides,
		Inf:     inf,
		NaN:     nan,
	})
}

// UnmarshalJSON implements the json.Unarshaller interface.
// The custom unmarshaller is needed to decode Inf/NaN values.
func (na *NArray) UnmarshalJSON(b []byte) error {
	x := struct {
		Rank    int       `json:"rank"`
		Shape   []int     `json:"shape"`
		Data    []{{.Format}} `json:"data"`
		Strides []int     `json:"strides"`
		Inf     []int     `json:"inf,omitempty"`
		NaN     []int     `json:"nan,omitempty"`
	}{}

	err := json.Unmarshal(b, &x)
	if err != nil {
		return err
	}

	na.Rank = x.Rank
	na.Shape = x.Shape
	na.Data = x.Data
	na.Strides = x.Strides
	na.Decode(x.Inf, x.NaN)
	return nil
}

// String prints the narray
func (na *NArray) String() string {

	return na.Sprint(func(na *NArray, k int) bool {
		return true
	})
}

// equal returns true if |x-y|/(|avg(x,y)|+1) < tol.
func equal(x, y {{.Format}}, tol float64) bool {
	avg := (math.Abs(float64(x+y)) / 2.0)
	sErr := math.Abs(float64(x-y)) / (avg + 1)
	if sErr > tol {
		return false
	}
	return true
}

// EqualValues compares two narrays elementwise.
// Returns true if for all elements |x-y|/(|avg(x,y)|+1) < tol.
func EqualValues(x *NArray, y *NArray, tol float64) bool {
	if !EqualShape(x, y) {
		panic("narrays must have equal shape.")
	}
	for i, _ := range x.Data {
		if !equal(x.Data[i], y.Data[i], tol) {
			return false
		}
	}
	return true
}

func formatted(n, max int) string {
	b := bytes.NewBufferString(" ")
	for i := 0; i < nd(max)-nd(n); i++ {
		_, _ = b.WriteString(" ")
	}
	_, _ = b.WriteString(strconv.FormatInt(int64(n), 10))
	return b.String()
}

// num digits in number
func nd(n int) int {
	if n == 0 {
		return 1
	}
	return int(math.Log10(float64(n))) + 1
}

func cartesianProduct(s []int) [][]int {

	if len(s) == 1 {
		z := make([][]int, s[0], s[0])
		for k := range z {
			z[k] = []int{k}
		}
		return z
	}
	var result [][]int
	for i := 0; i < s[0]; i++ {
		x := cartesianProduct(s[1:])
		for _, v := range x {
			var sl []int
			sl = append(sl, i)
			sl = append(sl, v...)
			result = append(result, sl)
		}
	}
	return result
}

// Recursively find indices for query q.
// Helper func to generate narray subsets.
func querySubset(q, s []int) [][]int {

	if len(q) != len(s) {
		panic("size mismatch")
	}
	var result [][]int

	switch {
	case len(s) == 1 && q[0] >= 0:
		result = [][]int{[]int{q[0]}}

	case len(s) == 1 && q[0] < 0:
		result = make([][]int, s[0], s[0])
		for k := range result {
			result[k] = []int{k}
		}

	case q[0] >= 0:
		x := querySubset(q[1:], s[1:])
		for _, v := range x {
			var sl []int
			sl = append(sl, q[0])
			sl = append(sl, v...)
			result = append(result, sl)
		}

	case q[0] < 0:
		for i := 0; i < s[0]; i++ {
			x := querySubset(q[1:], s[1:])
			for _, v := range x {
				var sl []int
				sl = append(sl, i)
				sl = append(sl, v...)
				result = append(result, sl)
			}
		}
	}
	return result
}

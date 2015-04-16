// generated by narray; DO NOT EDIT
// more info at github.com/akualab/narray

package na32

import "math"

// Acosh applies math.Acosh() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Acosh(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Acosh:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Acosh(float64(v)))
	}
	return out
}

// Asin applies math.Asin() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Asin(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Asin:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Asin(float64(v)))
	}
	return out
}

// Acos applies math.Acos() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Acos(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Acos:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Acos(float64(v)))
	}
	return out
}

// Asinh applies math.Asinh() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Asinh(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Asinh:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Asinh(float64(v)))
	}
	return out
}

// Atan applies math.Atan() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Atan(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Atan:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Atan(float64(v)))
	}
	return out
}

// Atanh applies math.Atanh() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Atanh(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Atanh:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Atanh(float64(v)))
	}
	return out
}

// Cbrt applies math.Cbrt() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Cbrt(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Cbrt:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Cbrt(float64(v)))
	}
	return out
}

// Erf applies math.Erf() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Erf(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Erf:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Erf(float64(v)))
	}
	return out
}

// Erfc applies math.Erfc() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Erfc(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Erfc:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Erfc(float64(v)))
	}
	return out
}

// Exp applies math.Exp() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Exp(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Exp:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Exp(float64(v)))
	}
	return out
}

// Exp2 applies math.Exp2() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Exp2(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Exp2:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Exp2(float64(v)))
	}
	return out
}

// Expm1 applies math.Expm1() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Expm1(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Expm1:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Expm1(float64(v)))
	}
	return out
}

// Floor applies math.Floor() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Floor(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Floor:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Floor(float64(v)))
	}
	return out
}

// Ceil applies math.Ceil() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Ceil(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Ceil:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Ceil(float64(v)))
	}
	return out
}

// Trunc applies math.Trunc() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Trunc(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Trunc:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Trunc(float64(v)))
	}
	return out
}

// Gamma applies math.Gamma() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Gamma(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Gamma:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Gamma(float64(v)))
	}
	return out
}

// J0 applies math.J0() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func J0(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("J0:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.J0(float64(v)))
	}
	return out
}

// Y0 applies math.Y0() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Y0(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Y0:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Y0(float64(v)))
	}
	return out
}

// J1 applies math.J1() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func J1(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("J1:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.J1(float64(v)))
	}
	return out
}

// Y1 applies math.Y1() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Y1(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Y1:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Y1(float64(v)))
	}
	return out
}

// Log applies math.Log() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Log(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Log:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Log(float64(v)))
	}
	return out
}

// Log10 applies math.Log10() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Log10(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Log10:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Log10(float64(v)))
	}
	return out
}

// Log2 applies math.Log2() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Log2(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Log2:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Log2(float64(v)))
	}
	return out
}

// Log1p applies math.Log1p() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Log1p(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Log1p:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Log1p(float64(v)))
	}
	return out
}

// Logb applies math.Logb() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Logb(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Logb:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Logb(float64(v)))
	}
	return out
}

// Cos applies math.Cos() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Cos(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Cos:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Cos(float64(v)))
	}
	return out
}

// Sin applies math.Sin() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Sin(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Sin:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Sin(float64(v)))
	}
	return out
}

// Sinh applies math.Sinh() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Sinh(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Sinh:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Sinh(float64(v)))
	}
	return out
}

// Cosh applies math.Cosh() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Cosh(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Cosh:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Cosh(float64(v)))
	}
	return out
}

// Tan applies math.Tan() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Tan(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Tan:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Tan(float64(v)))
	}
	return out
}

// Tanh applies math.Tanh() elementwise to a multidimensional array.
// See math package in standard lib for details.
//
// If 'out' is nil a new array is created.
// Will panic if 'out' and 'in' shapes don't match.
func Tanh(out, in *NArray) *NArray {
	if out == nil {
		out = New(in.Shape...)
	} else if !EqualShape(out, in) {
		panic("Tanh:narrays must have equal shape.")
	}
	for k, v := range in.Data {
		out.Data[k] = float32(math.Tanh(float64(v)))
	}
	return out
}

// Atan2 applies math.Atan2() elementwise to two multidimensional arrays.
// See math package in standard lib for details.
//
// If out is nil a new array is created.
// Will panic if 'out', 'a' and 'b' shapes don't match.
func Atan2(out, a, b *NArray) *NArray {
	if out == nil {
		out = New(a.Shape...)
	}
	if !EqualShape(out, a, b) {
		panic("Atan2:narrays must have equal shape.")
	}
	for k, v := range a.Data {
		out.Data[k] = float32(math.Atan2(float64(v), float64(b.Data[k])))
	}
	return out
}

// Dim applies math.Dim() elementwise to two multidimensional arrays.
// See math package in standard lib for details.
//
// If out is nil a new array is created.
// Will panic if 'out', 'a' and 'b' shapes don't match.
func Dim(out, a, b *NArray) *NArray {
	if out == nil {
		out = New(a.Shape...)
	}
	if !EqualShape(out, a, b) {
		panic("Dim:narrays must have equal shape.")
	}
	for k, v := range a.Data {
		out.Data[k] = float32(math.Dim(float64(v), float64(b.Data[k])))
	}
	return out
}

// Hypot applies math.Hypot() elementwise to two multidimensional arrays.
// See math package in standard lib for details.
//
// If out is nil a new array is created.
// Will panic if 'out', 'a' and 'b' shapes don't match.
func Hypot(out, a, b *NArray) *NArray {
	if out == nil {
		out = New(a.Shape...)
	}
	if !EqualShape(out, a, b) {
		panic("Hypot:narrays must have equal shape.")
	}
	for k, v := range a.Data {
		out.Data[k] = float32(math.Hypot(float64(v), float64(b.Data[k])))
	}
	return out
}

// Mod applies math.Mod() elementwise to two multidimensional arrays.
// See math package in standard lib for details.
//
// If out is nil a new array is created.
// Will panic if 'out', 'a' and 'b' shapes don't match.
func Mod(out, a, b *NArray) *NArray {
	if out == nil {
		out = New(a.Shape...)
	}
	if !EqualShape(out, a, b) {
		panic("Mod:narrays must have equal shape.")
	}
	for k, v := range a.Data {
		out.Data[k] = float32(math.Mod(float64(v), float64(b.Data[k])))
	}
	return out
}

// Pow applies math.Pow() elementwise to two multidimensional arrays.
// See math package in standard lib for details.
//
// If out is nil a new array is created.
// Will panic if 'out', 'a' and 'b' shapes don't match.
func Pow(out, a, b *NArray) *NArray {
	if out == nil {
		out = New(a.Shape...)
	}
	if !EqualShape(out, a, b) {
		panic("Pow:narrays must have equal shape.")
	}
	for k, v := range a.Data {
		out.Data[k] = float32(math.Pow(float64(v), float64(b.Data[k])))
	}
	return out
}

// Remainder applies math.Remainder() elementwise to two multidimensional arrays.
// See math package in standard lib for details.
//
// If out is nil a new array is created.
// Will panic if 'out', 'a' and 'b' shapes don't match.
func Remainder(out, a, b *NArray) *NArray {
	if out == nil {
		out = New(a.Shape...)
	}
	if !EqualShape(out, a, b) {
		panic("Remainder:narrays must have equal shape.")
	}
	for k, v := range a.Data {
		out.Data[k] = float32(math.Remainder(float64(v), float64(b.Data[k])))
	}
	return out
}

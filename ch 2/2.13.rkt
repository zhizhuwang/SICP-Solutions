
a = [Ca - Ca*Pa, Ca + Ca*Pa]
b = [Cb - Cb*Pb, Cb + Cb*Pb]

a * b ->
[(Ca - Ca*Pa)*(Cb - Cb*Pb), (Ca - Ca*Pa)*(Cb - Cb*Pb)]  ->
[Ca*Cb*(1 - Pa)*(1 - Pb),Ca*Cb*(1 + Pa)*(1 + Pb)]  ->
[Ca*Cb*(1 - Pa - Pb - Pa*Pb),Ca*Cb*(1 + Pa + Pb + Pa*Pb)]  ==> Pa is small, and Pb is small, so Pa*Pb is wee, can be ignored
[Ca*Cb*(1 - Pa - Pb),Ca*Cb*(1 + Pa + Pb)]  ->
[Ca*Cb*(1 - (Pa + Pb)),Ca*Cb*(1 + (Pa + Pb))]  ->

(define a (make-center-percent 10 0.5))
> (define b (make-center-percent 10 0.4))
> (percent-torlerence (mul-interval a b))
0.8999820003599912 
#pretty closed to (0.4+0.5)


mxA="data_A.bin"
mxB="data_B.bin"
result="rnd_data.bin"
rnd="randomizer_param"

./$rnd $1

mv $result $mxA
./$rnd $1

mv $result $mxB



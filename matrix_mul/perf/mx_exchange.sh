mxA="data_A.bin"
mxB="data_B.bin"
result="rnd_data.bin"
rnd="randomizer_param_fin"
sz="8000000"

./$rnd $sz

mv $result $mxA
./$rnd $sz

mv $result $mxB



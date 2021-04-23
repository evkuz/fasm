mxA="data_A.bin"
mxB="data_B.bin"
result="rnd_data.bin"
rnd="randomizer_ubuntu_mln"

./$rnd

mv $result $mxA
./$rnd

mv $result $mxB



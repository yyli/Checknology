           	cp          chk_vld_mv_x1       two
           	cp          chk_vld_mv_y1       one
           	cp          chk_vld_mv_x2       x
           	cp          chk_vld_mv_y2       y
           	cp		    chk_vld_mv_piece	negone
           	call        chk_vld_mv		    chk_vld_mv_retvar
           	cp 		    end				    chk_vld_mv_vld
           	halt

zero		.data		0
two 	   	.data		2
one			.data		1
x			.data		1
y			.data		2
negone		.data		-1
retvar		.data		0


#include chk_vld_mv.e
#include calc_pos.e
#include data.e

end			.data		0
asdf		.data		255
chk_jumps       cp          chk_jumps_pos1       negmid
                cp          chk_jumps_pos2       negmid
                cp          chk_jumps_pos3       negmid
                cp          chk_jumps_pos4       negmid
                cp          chk_jumps_avl        zero
                cp          chk_vld_num          two
                cp          chk_jumps_end        zero
                cp          chk_jumps_vld2       zero
                cp          chk_jumps_vld3       zero
                cp          chk_vld_mv_piece     tpiece
                be          chk_jumps_r          tpiece                 negone
                be          chk_jumps_b          tpiece                 one
chk_jumps_k     cp          chk_vld_mv_x1        chk_vld_mv_x2
                cp          chk_vld_mv_y1        chk_vld_mv_y2
                add         calc_pos_x           chk_vld_mv_x1          chk_vld_num
                add         calc_pos_y           chk_vld_mv_y1          chk_vld_num
                cp          chk_vld_mv_x2        calc_pos_x
                cp          chk_vld_mv_y2        calc_pos_y
                call        chk_vld_mv           chk_vld_mv_retvar
                and         chk_jumps_vld2       chk_vld_mv_vld         chk_vld_mv_mid
                bne         chk_jumps_k3         chk_jumps_vld2         one
                cp          chk_jumps_avl        one
                cp          chk_jumps_pos2       chk_vld_mv_pos2
chk_jumps_k3    sub         calc_pos_x           chk_vld_mv_x1          chk_vld_num
                add         calc_pos_y           chk_vld_mv_y1          chk_vld_num
                cp          chk_vld_mv_x2        calc_pos_x
                cp          chk_vld_mv_y2        calc_pos_y
                call        chk_vld_mv           chk_vld_mv_retvar
                and         chk_jumps_vld3       chk_vld_mv_vld         chk_vld_mv_mid
                cp          chk_jumps_pos1       chk_vld_mv_pos2 
                bne         chk_jumps_kfin       chk_jumps_vld3         one
                cp          chk_jumps_avl        one
chk_jumps_kfin  or          chk_jumps_end1       chk_jumps_vld2         chk_jumps_vld3
chk_jumps_bk    add         calc_pos_x           chk_vld_mv_x1          chk_vld_num
                sub         calc_pos_y           chk_vld_mv_y1          chk_vld_num
                cp          chk_vld_mv_x2        calc_pos_x
                cp          chk_vld_mv_y2        calc_pos_y
                call        chk_vld_mv           chk_vld_mv_retvar
                and         chk_jumps_vld2       chk_vld_mv_vld         chk_vld_mv_mid
                bne         chk_jumps_bk3        chk_jumps_vld2         one
                cp          chk_jumps_pos3       chk_vld_mv_pos2
                cp          chk_jumps_avl        one
chk_jumps_bk3   sub         calc_pos_x           chk_vld_mv_x1          chk_vld_num
                sub         calc_pos_y           chk_vld_mv_y1          chk_vld_num
                cp          chk_vld_mv_x2        calc_pos_x
                cp          chk_vld_mv_y2        calc_pos_y
                call        chk_vld_mv           chk_vld_mv_retvar
                and         chk_jumps_vld3       chk_vld_mv_vld         chk_vld_mv_mid 
                cp          chk_jumps_pos4       chk_vld_mv_pos2
                bne         chk_jumps_bfin       chk_jumps_vld3         one
                cp          chk_jumps_avl        one
chk_jumps_bfin  or          chk_jumps_end2       chk_jumps_vld2         chk_jumps_vld3
                or          chk_jumps_end        chk_jumps_end1         chk_jumps_end2        
                ret         chk_jumps_retvar
chk_jumps_r     cp          chk_vld_mv_x1        chk_vld_mv_x2
                cp          chk_vld_mv_y1        chk_vld_mv_y2
                add         calc_pos_x           chk_vld_mv_x1          chk_vld_num
                add         calc_pos_y           chk_vld_mv_y1          chk_vld_num
                cp          chk_vld_mv_x2        calc_pos_x
                cp          chk_vld_mv_y2        calc_pos_y
                call        chk_vld_mv           chk_vld_mv_retvar
                and         chk_jumps_vld2       chk_vld_mv_vld         chk_vld_mv_mid
                cp          chk_jumps_pos1       chk_vld_mv_pos2
                bne         chk_jumps_r3         chk_jumps_vld2         one
                cp          chk_jumps_avl        one
chk_jumps_r3    sub         calc_pos_x           chk_vld_mv_x1          chk_vld_num
                add         calc_pos_y           chk_vld_mv_y1          chk_vld_num
                cp          chk_vld_mv_x2        calc_pos_x
                cp          chk_vld_mv_y2        calc_pos_y
                call        chk_vld_mv           chk_vld_mv_retvar
                and         chk_jumps_vld3       chk_vld_mv_vld         chk_vld_mv_mid 
                or          chk_jumps_end        chk_jumps_vld2         chk_jumps_vld3
                cp          chk_jumps_pos2       chk_vld_mv_pos2
                bne         chk_jumps_fin        chk_jumps_vld3         one
                cp          chk_jumps_avl        one
                be          chk_jumps_fin        zero                   zero
chk_jumps_b     cp          chk_vld_mv_x1        chk_vld_mv_x2
                cp          chk_vld_mv_y1        chk_vld_mv_y2                
                add         calc_pos_x           chk_vld_mv_x1          chk_vld_num
                sub         calc_pos_y           chk_vld_mv_y1          chk_vld_num
                cp          chk_vld_mv_x2        calc_pos_x
                cp          chk_vld_mv_y2        calc_pos_y
                call        chk_vld_mv           chk_vld_mv_retvar
                and         chk_jumps_vld2       chk_vld_mv_vld         chk_vld_mv_mid
                cp          chk_jumps_pos1       chk_vld_mv_pos2
                bne         chk_jumps_b3         chk_jumps_vld2         one
                cp          chk_jumps_avl        one
chk_jumps_b3    sub         calc_pos_x           chk_vld_mv_x1          chk_vld_num
                sub         calc_pos_y           chk_vld_mv_y1          chk_vld_num
                cp          chk_vld_mv_x2        calc_pos_x
                cp          chk_vld_mv_y2        calc_pos_y
                call        chk_vld_mv           chk_vld_mv_retvar
                and         chk_jumps_vld3       chk_vld_mv_vld         chk_vld_mv_mid 
                or          chk_jumps_end        chk_jumps_vld2         chk_jumps_vld3
                cp          chk_jumps_pos2       chk_vld_mv_pos2
                bne         chk_jumps_fin        chk_jumps_vld3         one
                cp          chk_jumps_avl        one
                be          chk_jumps_fin        zero                   zero
chk_jumps_fin   or          chk_jumps_end        chk_jumps_vld2         chk_jumps_vld3
                ret         chk_jumps_retvar
                
chk_jumps_avl       .data       0
chk_jumps_end1      .data       0
chk_jumps_end2      .data       0
chk_vld_num         .data       0                
chk_jumps_end       .data       0
chk_jumps_vld2      .data       0
chk_jumps_vld3      .data       0
chk_jumps_retvar    .data       0
jump_pos1           .data       0
jump_pos2           .data       0
jump_pos3           .data       0
chk_jumps_pos1      .data       -32000
chk_jumps_pos2      .data       -32000
chk_jumps_pos3      .data       -32000
chk_jumps_pos4      .data       -32000
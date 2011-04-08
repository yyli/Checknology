chkvalidsq          cp          calc_pos_y          chkvalidsq_q
                    cp          calc_pos_x          chkvalidsq_p
                    call        calc_pos            calc_pos_retvar
                    cp          chkvalidsq_ppos     calc_pos_end
                    cpfa        chkvalidsq_piece    board               chkvalidsq_ppos
                    bne         chkvalidsq_skip1    selected            chkvalidsq_zero
                    be          chkvalidsq_over     chkvalidsq_piece    chkvalidsq_zero
                    be          chkvalidsq_turn_r   turnvar             zero
                    bne         chkvalidsq_turn_b   turnvar             zero
chkvalidsq_skip1    bne         chkvalidsq_skip     selected            chkvalidsq_one
                    bne         chkvalidsq_over     chkvalidsq_piece    chkvalidsq_zero                                  
chkvalidsq_skip     and         chkvalidsq_step1    chkvalidsq_p        chkvalidsq_q
                    not         chkvalidsq_step2    chkvalidsq_step1
                    or          chkvalidsq_step3    chkvalidsq_p        chkvalidsq_q
                    and         chkvalidsq_endxor   chkvalidsq_step2    chkvalidsq_step3
                    and         chkvalidsq_end      chkvalidsq_endxor   chkvalidsq_one
                    ret         chkvalidsq_retvar
chkvalidsq_over     cp          chkvalidsq_end      zero
                    ret         chkvalidsq_retvar
chkvalidsq_turn_r   be          chkvalidsq_over     chkvalidsq_piece    one
                    be          chkvalidsq_over     chkvalidsq_piece    two
                    be          chkvalidsq_skip     zero                zero
chkvalidsq_turn_b   be          chkvalidsq_over     chkvalidsq_piece    negone
                    be          chkvalidsq_over     chkvalidsq_piece    negtwo
                    be          chkvalidsq_skip     zero                zero

chkvalidsq_zero     .data   0
chkvalidsq_ppos     .data   0
chkvalidsq_piece    .data   0
chkvalidsq_retvar   .data   0
chkvalidsq_one      .data   1
chkvalidsq_two      .data   2
chkvalidsq_p        .data   0
chkvalidsq_q        .data   0
chkvalidsq_step1    .data   0
chkvalidsq_step2    .data   0
chkvalidsq_step3    .data   0
chkvalidsq_endxor   .data   0
chkvalidsq_end      .data   0
chkvalidsq          and         chkvalidsq_step1   chkvalidsq_p       chkvalidsq_q
                    not         chkvalidsq_step2   chkvalidsq_step1
                    or          chkvalidsq_step3   chkvalidsq_p       chkvalidsq_q
                    and         chkvalidsq_endxor  chkvalidsq_step2   chkvalidsq_step3
                    and         chkvalidsq_end     chkvalidsq_endxor  chkvalidsq_one
                    ret         chkvalidsq_retvar

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
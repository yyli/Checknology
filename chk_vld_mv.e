chk_vld_mv                  cp              chk_vld_mv_xvldv            chk_vld_mv_zero
                            cp              chk_vld_mv_yvldv            chk_vld_mv_zero
                            cp              chk_vld_mv_mid              chk_vld_mv_zero
                            cp              chk_vld_mv_king             chk_vld_mv_zero
                            cp              calc_pos_x                  chk_vld_mv_x2
                            cp              calc_pos_y                  chk_vld_mv_y2
                            call            calc_pos                    calc_pos_retvar
                            cpfa            chk_vld_mv_dump             board                   calc_pos_end
                            bne             chk_vld_mv_end              chk_vld_mv_dump         zero
                            blt             chk_vld_mv_end              eight                   chk_vld_mv_x2
                            blt             chk_vld_mv_end              eight                   chk_vld_mv_x2
                            blt             chk_vld_mv_end              chk_vld_mv_x2           one
                            blt             chk_vld_mv_end              chk_vld_mv_x2           one
                            blt             chk_vld_mv_end              eight                   chk_vld_mv_y2
                            blt             chk_vld_mv_end              eight                   chk_vld_mv_y2
                            blt             chk_vld_mv_end              chk_vld_mv_y2           one
                            blt             chk_vld_mv_end              chk_vld_mv_y2           one
                            blt             chk_vld_mv_end              eight                   chk_vld_mv_x1
                            blt             chk_vld_mv_end              eight                   chk_vld_mv_x1
                            blt             chk_vld_mv_end              chk_vld_mv_x1           one
                            blt             chk_vld_mv_end              chk_vld_mv_x1           one
                            blt             chk_vld_mv_end              eight                   chk_vld_mv_y1
                            blt             chk_vld_mv_end              eight                   chk_vld_mv_y1
                            blt             chk_vld_mv_end              chk_vld_mv_y1           one
                            blt             chk_vld_mv_end              chk_vld_mv_y1           one
                            be              chk_vld_mv_end              chk_vld_mv_piece        chk_vld_mv_zero
                            be              chk_vld_mv_k                chk_vld_mv_piece        chk_vld_mv_negtwo
                            be              chk_vld_mv_k                chk_vld_mv_piece        chk_vld_mv_two
                            be              chk_vld_mv_r                chk_vld_mv_piece        chk_vld_mv_negone
                            be              chk_vld_mv_b                chk_vld_mv_piece        chk_vld_mv_one
chk_vld_mv_end              and             chk_vld_mv_vld              chk_vld_mv_xvldv        chk_vld_mv_yvldv
                            ret             chk_vld_mv_retvar
//check Kings
chk_vld_mv_k                blt             chk_vld_mv_adjust           chk_vld_mv_piece        chk_vld_mv_zero
                            cp              chk_vld_mv_piece            chk_vld_mv_two
                            cp              chk_vld_mv_piece2           chk_vld_mv_one
chk_vld_mv_adjust_end       sub             chk_vld_mv_xdiff            chk_vld_mv_x1           chk_vld_mv_x2
                            mult            chk_vld_mv_xdiff            chk_vld_mv_xdiff        chk_vld_mv_xdiff
                            sub             chk_vld_mv_ydiff            chk_vld_mv_y1           chk_vld_mv_y2
                            mult            chk_vld_mv_ydiff            chk_vld_mv_ydiff        chk_vld_mv_ydiff    
                            //checks
                            be              chk_vld_mv_k_past           chk_vld_mv_xdiff        chk_vld_mv_one
                            be              chk_vld_mv_k_past           chk_vld_mv_ydiff        chk_vld_mv_one
                            blt             chk_vld_mv_next_t_2         chk_vld_mv_y2           chk_vld_mv_y1
                            be              chk_vld_mv_next_t_1         zero                    zero
chk_vld_mv_next_t_1         blt             chk_vld_mv_k2_t             chk_vld_mv_x2           chk_vld_mv_x1
                            sub             chk_vld_mv_dump             chk_vld_mv_x2           chk_vld_mv_one
                            cp              calc_pos_x                  chk_vld_mv_dump
                            sub             chk_vld_mv_dump             chk_vld_mv_y2           chk_vld_mv_one
                            cp              calc_pos_y                  chk_vld_mv_dump
                            call            calc_pos                    calc_pos_retvar
chk_vld_mv_k_ret_t          cpfa            chk_vld_mv_dump             board                   calc_pos_end
                            cp              chk_vld_mv_midloc           calc_pos_end
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_zero
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_piece
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_piece2
                            cp              chk_vld_mv_mid              chk_vld_mv_one
                            be              chk_vld_mv_k_past           zero                    zero
chk_vld_mv_next_t_2         blt             chk_vld_mv_k2_b             chk_vld_mv_x2           chk_vld_mv_x1
                            sub             chk_vld_mv_dump             chk_vld_mv_x2           chk_vld_mv_one
                            cp              calc_pos_x                  chk_vld_mv_dump
                            add             chk_vld_mv_dump             chk_vld_mv_y2           chk_vld_mv_one
                            cp              calc_pos_y                  chk_vld_mv_dump
                            call            calc_pos                    calc_pos_retvar
chk_vld_mv_k_ret_b          cpfa            chk_vld_mv_dump             board                   calc_pos_end
                            cp              chk_vld_mv_midloc           calc_pos_end
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_zero
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_piece
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_piece2
                            cp              chk_vld_mv_mid              chk_vld_mv_one
chk_vld_mv_k_past           blt             chk_vld_mv_end              chk_vld_mv_four         chk_vld_mv_xdiff        
                            be              chk_vld_mv_end              chk_vld_mv_xdiff        zero
                            cp              chk_vld_mv_xvldv            chk_vld_mv_one
                            be              chk_vld_mv_end              chk_vld_mv_ydiff        zero
                            blt             chk_vld_mv_end              chk_vld_mv_four         chk_vld_mv_ydiff     
                            cp              chk_vld_mv_yvldv            chk_vld_mv_one      
                            //end check
                            be              chk_vld_mv_end              zero                    zero
//check red
chk_vld_mv_r                sub             chk_vld_mv_xdiff            chk_vld_mv_x1           chk_vld_mv_x2
                            mult            chk_vld_mv_xdiff            chk_vld_mv_xdiff        chk_vld_mv_xdiff
                            sub             chk_vld_mv_ydiff            chk_vld_mv_y1           chk_vld_mv_y2
                            mult            chk_vld_mv_ydiff            chk_vld_mv_ydiff        chk_vld_mv_ydiff
                            //checks
                            be              chk_vld_mv_r_past           chk_vld_mv_xdiff        chk_vld_mv_one
                            blt             chk_vld_mv_r2               chk_vld_mv_x2           chk_vld_mv_x1
                            sub             chk_vld_mv_dump             chk_vld_mv_x2           chk_vld_mv_one
                            cp              calc_pos_x                  chk_vld_mv_dump
                            sub             chk_vld_mv_dump             chk_vld_mv_y2           chk_vld_mv_one
                            cp              calc_pos_y                  chk_vld_mv_dump
                            call            calc_pos                    calc_pos_retvar
chk_vld_mv_r_ret            cpfa            chk_vld_mv_dump             board                   calc_pos_end
                            cp              chk_vld_mv_midloc           calc_pos_end
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_zero
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_negone
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_negtwo
                            cp              chk_vld_mv_mid              chk_vld_mv_one
chk_vld_mv_r_past           blt             chk_vld_mv_end              chk_vld_mv_four         chk_vld_mv_xdiff        
                            be              chk_vld_mv_end              chk_vld_mv_xdiff        zero
                            cp              chk_vld_mv_xvldv            chk_vld_mv_one
                            be              chk_vld_mv_end              chk_vld_mv_ydiff        zero
                            blt             chk_vld_mv_end              chk_vld_mv_four         chk_vld_mv_ydiff
                            blt             chk_vld_mv_end              chk_vld_mv_y2           chk_vld_mv_y1     
                            cp              chk_vld_mv_yvldv            chk_vld_mv_one
                            bne             chk_vld_mv_end              chk_vld_mv_y2           chk_vld_mv_eight
                            cp              chk_vld_mv_king             chk_vld_mv_negone     
                            //end check
                            be              chk_vld_mv_end              zero                    zero
//check black                            
chk_vld_mv_b                sub             chk_vld_mv_xdiff            chk_vld_mv_x1           chk_vld_mv_x2
                            mult            chk_vld_mv_xdiff            chk_vld_mv_xdiff        chk_vld_mv_xdiff
                            sub             chk_vld_mv_ydiff            chk_vld_mv_y1           chk_vld_mv_y2
                            mult            chk_vld_mv_ydiff            chk_vld_mv_ydiff        chk_vld_mv_ydiff
                            //checks
                            be              chk_vld_mv_b_past           chk_vld_mv_xdiff        chk_vld_mv_one
                            blt             chk_vld_mv_b2               chk_vld_mv_x2           chk_vld_mv_x1
                            sub             chk_vld_mv_dump             chk_vld_mv_x2           chk_vld_mv_one
                            cp              calc_pos_x                  chk_vld_mv_dump
                            add             chk_vld_mv_dump             chk_vld_mv_y2           chk_vld_mv_one
                            cp              calc_pos_y                  chk_vld_mv_dump
                            call            calc_pos                    calc_pos_retvar
chk_vld_mv_b_ret            cpfa            chk_vld_mv_dump             board                   calc_pos_end
                            cp              chk_vld_mv_midloc           calc_pos_end
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_zero
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_one
                            be              chk_vld_mv_end              chk_vld_mv_dump         chk_vld_mv_two
                            cp              chk_vld_mv_mid              chk_vld_mv_one
chk_vld_mv_b_past           blt             chk_vld_mv_end              chk_vld_mv_four         chk_vld_mv_xdiff        
                            be              chk_vld_mv_end              chk_vld_mv_xdiff        zero
                            cp              chk_vld_mv_xvldv            chk_vld_mv_one
                            be              chk_vld_mv_end              chk_vld_mv_ydiff        zero
                            blt             chk_vld_mv_end              chk_vld_mv_four         chk_vld_mv_ydiff
                            blt             chk_vld_mv_end              chk_vld_mv_y1           chk_vld_mv_y2     
                            cp              chk_vld_mv_yvldv            chk_vld_mv_one
                            bne             chk_vld_mv_end              chk_vld_mv_y2           chk_vld_mv_one
                            cp              chk_vld_mv_king             chk_vld_mv_one      
                            //end check
                            be              chk_vld_mv_end              zero                    zero

//extra check
chk_vld_mv_r2               add             chk_vld_mv_dump             chk_vld_mv_x2           chk_vld_mv_one
                            cp              calc_pos_x                  chk_vld_mv_dump
                            sub             chk_vld_mv_dump             chk_vld_mv_y2           chk_vld_mv_one
                            cp              calc_pos_y                  chk_vld_mv_dump
                            call            calc_pos                    calc_pos_retvar
                            be              chk_vld_mv_r_ret            zero                    zero
chk_vld_mv_b2               add             chk_vld_mv_dump             chk_vld_mv_x2           chk_vld_mv_one
                            cp              calc_pos_x                  chk_vld_mv_dump
                            add             chk_vld_mv_dump             chk_vld_mv_y2           chk_vld_mv_one
                            cp              calc_pos_y                  chk_vld_mv_dump
                            call            calc_pos                    calc_pos_retvar
                            be              chk_vld_mv_b_ret            zero                    zero
chk_vld_mv_k2_t             add             chk_vld_mv_dump             chk_vld_mv_x2           chk_vld_mv_one
                            cp              calc_pos_x                  chk_vld_mv_dump
                            sub             chk_vld_mv_dump             chk_vld_mv_y2           chk_vld_mv_one
                            cp              calc_pos_y                  chk_vld_mv_dump
                            call            calc_pos                    calc_pos_retvar
                            be              chk_vld_mv_k_ret_t          zero                    zero
chk_vld_mv_k2_b             add             chk_vld_mv_dump             chk_vld_mv_x2           chk_vld_mv_one
                            cp              calc_pos_x                  chk_vld_mv_dump
                            add             chk_vld_mv_dump             chk_vld_mv_y2           chk_vld_mv_one
                            cp              calc_pos_y                  chk_vld_mv_dump
                            call            calc_pos                    calc_pos_retvar
                            be              chk_vld_mv_k_ret_b          zero                    zero
chk_vld_mv_adjust           cp              chk_vld_mv_piece            chk_vld_mv_negtwo
                            cp              chk_vld_mv_piece2           chk_vld_mv_negone
                            be              chk_vld_mv_adjust_end       zero                    zero                     

chk_vld_mv_zero             .data           0
chk_vld_mv_one              .data           1
chk_vld_mv_two              .data           2
chk_vld_mv_four             .data           4
chk_vld_mv_five             .data           5
chk_vld_mv_eight            .data           8
chk_vld_mv_negone           .data           -1
chk_vld_mv_negtwo           .data           -2
chk_vld_mv_xdiff            .data           0
chk_vld_mv_ydiff            .data           0
chk_vld_mv_retvar           .data           0
chk_vld_mv_x2               .data           0
chk_vld_mv_y2               .data           0
chk_vld_mv_xvldv            .data           0
chk_vld_mv_yvldv            .data           0
chk_vld_mv_vld              .data           0
chk_vld_mv_piece            .data           0
chk_vld_mv_piece2           .data           0
chk_vld_mv_mid              .data           0
chk_vld_mv_midloc           .data           0
chk_vld_mv_king             .data           0
chk_vld_mv_x1               .data           0
chk_vld_mv_y1               .data           0
chk_vld_mv_test1            .data           0
chk_vld_mv_test2            .data           0
chk_vld_mv_dump             .data           0
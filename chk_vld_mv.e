chk_vld_mv                  cp              chk_vld_mv_xvldv            chk_vld_mv_zero
                            cp              chk_vld_mv_yvldv            chk_vld_mv_zero
                            be              chk_vld_mv_end              chk_vld_mv_piece        chk_vld_mv_zero
                            be              chk_vld_mv_k                chk_vld_mv_piece        chk_vld_mv_negtwo
                            be              chk_vld_mv_k                chk_vld_mv_piece        chk_vld_mv_two
                            be              chk_vld_mv_r                chk_vld_mv_piece        chk_vld_mv_negone
                            be              chk_vld_mv_b                chk_vld_mv_piece        chk_vld_mv_one
chk_vld_mv_end              and             chk_vld_mv_vld              chk_vld_mv_xvldv        chk_vld_mv_yvldv
                            ret             chk_vld_mv_retvar
chk_vld_mv_k                sub             chk_vld_mv_xdiff            chk_vld_mv_x1           chk_vld_mv_x2
                            mult            chk_vld_mv_xdiff            chk_vld_mv_xdiff        chk_vld_mv_xdiff
                            sub             chk_vld_mv_ydiff            chk_vld_mv_y1           chk_vld_mv_y2
                            mult            chk_vld_mv_ydiff            chk_vld_mv_ydiff        chk_vld_mv_ydiff
                            blt             chk_vld_mv_kxvld            chk_vld_mv_xdiff        chk_vld_mv_five
chk_vld_mv_ky               blt             chk_vld_mv_kyvld            chk_vld_mv_ydiff        chk_vld_mv_five
                            be              chk_vld_mv_end              zero                    zero
chk_vld_mv_r                sub             chk_vld_mv_xdiff            chk_vld_mv_x1           chk_vld_mv_x2
                            mult            chk_vld_mv_xdiff            chk_vld_mv_xdiff        chk_vld_mv_xdiff
                            sub             chk_vld_mv_ydiff            chk_vld_mv_y1           chk_vld_mv_y2
                            mult            chk_vld_mv_ydiff            chk_vld_mv_ydiff        chk_vld_mv_ydiff
                            blt             chk_vld_mv_rxvld            chk_vld_mv_xdiff        chk_vld_mv_five
chk_vld_mv_ry               blt             chk_vld_mv_ryvld            chk_vld_mv_y1           chk_vld_mv_y2
                            be              chk_vld_mv_end              zero                    zero
chk_vld_mv_b                sub             chk_vld_mv_xdiff            chk_vld_mv_x1           chk_vld_mv_x2
                            mult            chk_vld_mv_xdiff            chk_vld_mv_xdiff        chk_vld_mv_xdiff
                            sub             chk_vld_mv_ydiff            chk_vld_mv_y1           chk_vld_mv_y2
                            mult            chk_vld_mv_ydiff            chk_vld_mv_ydiff        chk_vld_mv_ydiff
                            blt             chk_vld_mv_bxvld            chk_vld_mv_xdiff        chk_vld_mv_five
chk_vld_mv_by               blt             chk_vld_mv_byvld            chk_vld_mv_y2           chk_vld_mv_y1
                            be              chk_vld_mv_end              zero                    zero                            
chk_vld_mv_bxvld            cp              chk_vld_mv_xvldv            chk_vld_mv_one        
                            be              chk_vld_mv_by               zero                    zero
chk_vld_mv_byvld            cp              chk_vld_mv_yvldv            chk_vld_mv_one
                            be              chk_vld_mv_end              zero                    zero
chk_vld_mv_rxvld            cp              chk_vld_mv_xvldv            chk_vld_mv_one        
                            be              chk_vld_mv_ry               zero                    zero
chk_vld_mv_ryvld            blt             chk_vld_mv_end              chk_vld_mv_four         chk_vld_mv_ydiff
                            cp              chk_vld_mv_yvldv            chk_vld_mv_one
                            be              chk_vld_mv_end              zero                    zero
chk_vld_mv_kxvld            cp              chk_vld_mv_xvldv            chk_vld_mv_one        
                            be              chk_vld_mv_ky               zero                    zero
chk_vld_mv_kyvld            cp              chk_vld_mv_yvldv            chk_vld_mv_one
                            be              chk_vld_mv_end              zero                    zero

chk_vld_mv_zero             .data           0
chk_vld_mv_one              .data           1
chk_vld_mv_two              .data           2
chk_vld_mv_four             .data           4
chk_vld_mv_five             .data           5
chk_vld_mv_negone           .data           -1
chk_vld_mv_negtwo           .data           -2
chk_vld_mv_xdiff            .data           0
chk_vld_mv_ydiff            .data           0
chk_vld_mv_retvar           .data           0
chk_vld_mv_x1               .data           0
chk_vld_mv_y1               .data           0
chk_vld_mv_x2               .data           0
chk_vld_mv_y2               .data           0
chk_vld_mv_piece            .data           0
chk_vld_mv_xvldv            .data           0
chk_vld_mv_yvldv            .data           0
chk_vld_mv_vld              .data           0

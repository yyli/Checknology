// This function will tell you if you win
// -1 means red wins
// 1 means blk wins
// 0 means game is in progress

chk_win     			cp          i                   zero                                        //resets i
						cp			chk_win_redvar		zero										//reset redvar
						cp			chk_win_blkvar		zero										//reset blkvar
chk_win_i				cp			chk_win_end		    zero										//resets end
						cpfa		chk_win_temp		board			i
						blt			chk_win_red			chk_win_temp	zero
						blt			chk_win_blk			zero			chk_win_temp
chk_win_inc             add         i                   i               one
                        blt         chk_win_i     		i               thirtytwo
                        be			chk_win_red_e		chk_win_blkvar	zero
                        be			chk_win_blk_e		chk_win_redvar	zero
                        ret			chk_win_retvar
chk_win_red				add			chk_win_redvar		chk_win_redvar	chk_win_temp
						be			chk_win_inc			zero			zero
chk_win_blk				add			chk_win_blkvar		chk_win_blkvar	chk_win_temp
						be			chk_win_inc			zero			zero
chk_win_red_e			cp			chk_win_end			negone
						cp          vga_x1              red_w_x1
                        cp          vga_x2              red_w_x2
                        cp          vga_y1              red_w_y1
                        cp          vga_y2              red_w_y2
                        cp          vga_color_out       three
                        call        vga_write_blk       vga_return
chk_win_red_l           call        mouse_loop          mouse_holder 
           				cp          chk_win_lclick      mouse_left
                        bne			chk_win_red_l		chk_win_lclick			one
						be          draw_init_piece_i   zero                    zero
chk_win_blk_e			cp			chk_win_end			one
						cp          vga_x1              blk_w_x1
                        cp          vga_x2              blk_w_x2
                        cp          vga_y1              blk_w_y1
                        cp          vga_y2              blk_w_y2
                        cp          vga_color_out       three
                        call        vga_write_blk       vga_return
chk_win_blk_l           call        mouse_loop          mouse_holder 
			            cp          chk_win_lclick      mouse_left
                        bne			chk_win_blk_l		chk_win_lclick			one
						be          draw_init_piece_i   zero                    zero
chk_win_clear			cp			chk_win_end			negone
						cp          vga_x1              red_w_x1
                        cp          vga_x2              red_w_x2
                        cp          vga_y1              red_w_y1
                        cp          vga_y2              red_w_y2
                        cp          vga_color_out       white
                        call        vga_write_blk       vga_return
                        cp          vga_x1              blk_w_x1
                        cp          vga_x2              blk_w_x2
                        cp          vga_y1              blk_w_y1
                        cp          vga_y2              blk_w_y2
                        cp          vga_color_out       white
                        call        vga_write_blk       vga_return
						ret			chk_win_retvar
						
chk_win_temp			.data		0
chk_win_retvar			.data		0
chk_win_end				.data		0
red_w_x1                .data       330
red_w_x2                .data       370
red_w_y1                .data       30
red_w_y2                .data       40
blk_w_x1                .data       330
blk_w_x2                .data       370
blk_w_y1                .data       320
blk_w_y2                .data       330
chk_win_redvar			.data		0
chk_win_blkvar			.data		0		
chk_win_lclick			.data		0	
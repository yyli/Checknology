draw_pvp	    call		draw_ai_clear		draw_ai_retvari
				cp          vga_x2              pvp_but_xmax_i
                cp          vga_x1              pvp_but_xmin_i
                cp          vga_y2              pvp_but_ymax_i
                cp          vga_y1              pvp_but_ymin_i
                cp          vga_color_out       three
                call        vga_write_blk       vga_return
                ret			draw_ai_retvar 
draw_ai_e	    call		draw_ai_clear		draw_ai_retvari
				cp          vga_x2              ai_e_but_xmax_i
                cp          vga_x1              ai_e_but_xmin_i
                cp          vga_y2              ai_e_but_ymax_i
                cp          vga_y1              ai_e_but_ymin_i
                cp          vga_color_out       three
                call        vga_write_blk       vga_return
                ret			draw_ai_retvar 
draw_ai_m		call		draw_ai_clear		draw_ai_retvari
				cp          vga_x2              ai_m_but_xmax_i
                cp          vga_x1              ai_m_but_xmin_i
                cp          vga_y2              ai_m_but_ymax_i
                cp          vga_y1              ai_m_but_ymin_i
                cp          vga_color_out       three
                call        vga_write_blk       vga_return
                ret			draw_ai_retvar
draw_ai_clear	cp          vga_x2              ai_e_but_xmax_i
                cp          vga_x1              ai_e_but_xmin_i
                cp          vga_y2              ai_e_but_ymax_i
                cp          vga_y1              ai_e_but_ymin_i
                cp          vga_color_out       white
                call        vga_write_blk       vga_return
                cp          vga_x2              ai_m_but_xmax_i
                cp          vga_x1              ai_m_but_xmin_i
                cp          vga_y2              ai_m_but_ymax_i
                cp          vga_y1              ai_m_but_ymin_i
                cp          vga_color_out       white
                call        vga_write_blk       vga_return
                cp          vga_x2              pvp_but_xmax_i
                cp          vga_x1              pvp_but_xmin_i
                cp          vga_y2              pvp_but_ymax_i
                cp          vga_y1              pvp_but_ymin_i
                cp          vga_color_out       white
                call        vga_write_blk       vga_return
				ret			draw_ai_retvari

draw_ai_retvari	.data		0
draw_ai_retvar	.data		0
ai_m_but_xmax_i .data       425
ai_m_but_xmin_i .data       415
ai_m_but_ymax_i .data       159
ai_m_but_ymin_i .data       149
ai_e_but_xmax_i .data       425
ai_e_but_xmin_i .data       415
ai_e_but_ymax_i .data       125
ai_e_but_ymin_i .data       115
pvp_but_xmax_i  .data       425
pvp_but_xmin_i  .data       415
pvp_but_ymax_i  .data       57
pvp_but_ymin_i  .data       47
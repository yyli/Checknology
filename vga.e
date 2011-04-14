vga_write_one   out         60              vga_zero
                out         63              vga_x1
                out         64              vga_y1
                out         65              vga_x1
                out         66              vga_y1
                out         67              vga_color_out
                out         62              vga_one
                out         60              vga_one
                in          61              vga_ack
                call        vga_ack_chk_out vga_dump
vga_write_blk   out         60              vga_zero
                out         63              vga_x1
                out         64              vga_y1
                out         65              vga_x2
                out         66              vga_y2
                out         67              vga_color_out
                out         62              vga_one
                out         60              vga_one
                in          61              vga_ack
                call        vga_ack_chk_out vga_dump
vga_read        out         60              vga_zero
                out         63              vga_x1
                out         64              vga_y1
                out         62              vga_zero
                out         60              vga_one
                call        vga_ack_chk_in  vga_dump
vga_ack_chk_out in          61              vga_ack
                be          vga_equal_out   vga_ack             vga_one
                be          vga_ack_chk_out vga_ack             vga_zero
vga_equal_out   out         60              vga_one
                cp          vga_check       vga_one
                ret         vga_return  
vga_ack_chk_in  in          61              vga_ack
                be          vga_equal_in    vga_ack             vga_one
                be          vga_ack_chk_in  vga_ack             vga_zero
vga_equal_in    in          68              vga_color_in
                out         60              vga_one
                cp          vga_check       vga_zero
                ret         vga_return                  

vga_return      .data       0
vga_color_out   .data       255
vga_one         .data       1
vga_zero        .data       0
vga_ack         .data       0
vga_x1          .data       0
vga_y1          .data       0
vga_x2          .data       639
vga_y2          .data       479
vga_dump        .data       0
vga_color_in    .data       101
vga_check       .data       100
vga_max_x       .data       639
vga_max_y       .data       479
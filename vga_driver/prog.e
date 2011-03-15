            cp      vga_x1          zero
            cp      vga_y1          zero
            cp      vga_x2          max_x
            cp      vga_y2          max_y
            cp      vga_color_out   white
            call    vga_write_blk   vga_return
            cp      dump            one        
check       blt     inc             i               color_len
            cp      vga_x1          one
            cp      vga_y1          zero
            call    vga_read        vga_return
            cp      dump            vga_color_in
            halt
inc         cp      vga_x1          i
            cp      vga_y1          zero
	    cp      vga_x2          i
            cp      vga_y2          max_y
            cpfa    vga_color_out   color           i
            call    vga_write_blk   vga_return
            add     i               i               one
            call    check           dump
            halt
        
color       .data   0
            .data   14
            .data   28
            .data   35
            .data   50
            .data   75
            .data   100
            .data   125
            .data   150
            .data   175
            .data   200
            .data   224
            .data   227
            .data   250
color_len   .data   15
white       .data   255
zero        .data   0
one         .data   1
max_x       .data   639
max_y       .data   479
dump        .data   255
i           .data   0

#include driver.e

        cp          vga_x1          zero
        cp          vga_y1          zero
        cp          vga_x2          vga_max_x
        cp          vga_y2          vga_max_y
        cp          vga_color_out   white
        call        vga_write_blk   vga_return
        cp          vga_x1          white
        cp          vga_y1          white
        cp          vga_color_out   black
        call        vga_write_one   vga_return
        cp          width           bg_w
        cp          height          bg_h
        sub         width-          width           one
        sub         height-         height          one
imgloop cp          vga_x1          w_i
        cp          vga_y1          h_i
        mult        i               width           h_i
        add         i               i               w_i
        cpfa        vga_color_out   img             i
        call        vga_write_one   vga_return
        be          setzero         w_i             width-
        add         w_i             w_i             one
        call        imgloop         dump
loop    cp          w_i             xold
        cp          h_i             yold
        cp          width           cur_l
        cp          height          cur_l
        sub         width-          width           one
        sub         height-         height          one
        cp          w_i             zero
        cp          h_i             zero
rloop   add         w_t             w_i             xold
        add         h_t             h_i             yold
        sub         w_t             w_t             two
        add         h_t             h_t             two  
        cp          vga_x1          w_t
        cp          vga_y1          h_t
        mult        i               width           h_i
        add         i               i               w_i
        call        vga_read        vga_return
        cpta        vga_color_in    old             i
        be          setz            w_i             width-  
        add         w_i             w_i             one
        call        rloop           dump
img_e   call        mouse_loop      mouse_holder
        cp          deltax          mouse_deltax
        cp          deltay          mouse_deltay 
        add         x               x               deltax
        add         y               y               deltay
chk_x   blt         xlow            x               zero
        blt         xhigh           vga_max_x       x
chk_y   blt         ylow            y               zero
        blt         yhigh           vga_max_y       y
set     call        as              retvar
        cp          vga_x1          x1
        cp          vga_x2          x2
        cp          vga_y1          y1
        cp          vga_y2          y2
        cp          vga_color_out   black
        call        vga_write_blk   vga_return
        call        img_e           dump
        halt
xlow    cp          x               0
        call        chk_y           dump
xhigh   cp          x               vga_max_x
        call        chk_y           dump
ylow    cp          y               0
        call        set             dump
yhigh   cp          y               vga_max_y
        call        set             dump
as      sub         x1              x               side_2
        add         x2              x               side_2
        sub         y1              y               side_2
        add         y2              y               side_2
        ret         retvar      
setzero cp          w_i             zero
        be          loop            h_i             height-
        add         h_i             h_i             one
        call        imgloop         dump
setz    cp          w_i             zero
        be          img_e           h_i             height-
        add         h_i             h_i             one
        call        rloop           dump
        
bg_w    .data   448
bg_h    .data   30
old     .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
        .data   0
retvar  .data   0
side_2  .data   1 
cur_l   .data   5                   
dump    .data   0
white   .data   255
black   .data   0
zero    .data   0
one     .data   1
two     .data   2
deltax  .data   0
deltay  .data   0
x       .data   0
y       .data   0
xold    .data   255
yold    .data   255
x1      .data   0
x2      .data   0
y1      .data   0
y2      .data   0
height  .data   0
height- .data   0
width   .data   0
width-  .data   0
i       .data   0
h_i     .data   0
w_i     .data   0
h_t     .data   0
w_t     .data   0

#include vga.e
#include mouse.e
#include image.e
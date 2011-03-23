        cp          vga_x1          zero                                        //copies zero into x1
        cp          vga_y1          zero                                        //copies zero into y1
        cp          vga_x2          vga_max_x                                   //copies xmax into x2
        cp          vga_y2          vga_max_y                                   //copies ymax into y2
        cp          vga_color_out   white                                       //copies white into the color out
        call        vga_write_blk   vga_return                                  //calls the write block function, and set the return variable
        cp          width           bg_w                                        //sets a temp width variable with the width of the bg that we want to paint
        cp          height          bg_h                                        //sets a temp height ...
        sub         width-          width           one                         //subtract one from width store in width-
        sub         height-         height          one                         //...               height ...     height-
imgloop cp          vga_x1          w_i                                         //copy w_i (width incrementor) into x1
        cp          vga_y1          h_i                                         //copy h_i (height incrementor) into y1
        mult        i               width           h_i                         //mult h_i with i (array incrementor)
        add         i               i               w_i                         //add w_i to i
        cpfa        vga_color_out   img             i                           //copy the color from array
        call        vga_write_one   vga_return                                  //call write one pixel
        be          setzero         w_i             width-                      //if width is maxwidth-1 then set it to zero
        add         w_i             w_i             one                         //add one to w_i
        call        imgloop         dump                                        //reloop imgloop
loop    cp          width           cur_l                                       //change temp width to cursor length
        cp          height          cur_l                                       //...         height ...
        sub         width-          width           one                         //width-1
        sub         height-         height          one                         //height-1
        cp          w_i             zero                                        //reset w_i
        cp          h_i             zero                                        //reset h_i
rloop   add         w_t             w_i             xold                        //add xold to w_i to get w_t (x pos incrementor)
        add         h_t             h_i             yold                        //add yold to h_i to get w_t (y pos incrementor)
        sub         w_t             w_t             two                         //sub two from w_t to get to the left side
        add         h_t             h_t             two                         //add two to h_t to get top side
        cp          vga_x1          w_t                                         //cp pos into x1
        cp          vga_y1          h_t                                         //...
        mult        i               width           h_i
        add         i               i               w_i
        call        vga_read        vga_return
        cpta        vga_color_in    old             i                           //read color in to array old
        be          setz            w_i             width-                      //check if zero
        add         w_i             w_i             one                         //add one
        call        rloop           dump                                        //reloop rloop
img_e   call        mouse_loop      mouse_holder
        cp          deltax          mouse_deltax
        cp          deltay          mouse_deltay
        cp          xold            x                                           //copies old x into oldx
        cp          yold            y                                           //copies old y into oldy
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
        call        loop            dump
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
//sets w_i to zero or end imgloop        
setzero cp          w_i             zero
        be          loop            h_i             height-
        add         h_i             h_i             one
        call        imgloop         dump
//sets w_i to zero or end rloop        
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
xold    .data   0
yold    .data   0
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

//		m_z = 255 * (m_z & 255) + (m_z >> 8);
//		m_w = 140 * (m_w & 255) + (m_w >> 8);
//		randnum = (m_z << 8) + m_w;
//		randnum = randnum & 255;
//		randnum = ((randnum*34)/255);

e_rand_num_gen		and  m_z_and   m_z           twofiftyfive
						sr   m_z_sr    m_z           eight
						mult m_z       twofiftyfive  m_z_and 
						add  m_z       m_z           m_z_sr

						and  m_w_and    m_w          twofiftyfive
						sr   m_w_sr     m_w          eight
						mult m_w        oneforty      m_w_and 
						add  m_w        m_w           m_w_sr

						sl   e_randnum       m_z          eight
						add  e_randnum       e_randnum    m_w
						and  e_randnum       e_randnum    twofiftyfive
						mult e_randnum       e_randnum    thirtyfour
						div  e_randnum       e_randnum    twofiftyfive
						ret  e_retvar_rand 

m_z          .data 478
m_z_and      .data 0
m_z_sr       .data 0
m_w          .data 754
m_w_and      .data 0
m_w_sr       .data 0
thirtyfour   .data 34
oneforty     .data 140
twofiftyfive .data 255
e_randnum      .data 0
e_retvar_rand  .data 0

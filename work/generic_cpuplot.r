library(ggplot2)
library(plotly)
library (hrbrthemes)

rho = (1:99)/100
cpu_count = 16

s = 1

R_1 = 1/ (s-(rho^1))

R_4 = 1 / (s-(rho^4))

R_8 = 1 / (s-(rho^8))

R_16 = 1 / (s-(rho^16))

d <- data.frame(CPU_Usage = rho, R_1, R_4,R_8,R_16)

# d<- d %>% filter (CPU_Usage < 0.5)

p<- d %>% ggplot (aes(x=CPU_Usage)) +
  labs(
    title="CPU % Used vs. Response Time", 
    subtitle="Theoretical curves for 16 CPU systems",
    x="Reported CPU Usage", 
    y= "Relative Response Time",
    colour="CPU Type") +
  # ylim(0,10) +
  theme_ipsum() +
  scale_x_continuous(breaks=c(0.2,0.4,0.6,0.8,1),labels=scales::percent) +
  scale_y_continuous(limits=c(1,5), breaks=c(0,1,2,3,4,5)) +
  geom_point(aes(y=R_1, color="Uni")) +
  geom_point(aes(y=R_4, color="4 Cores")) +
  geom_point(aes(y=R_16, color="16 Cores")) 

ggplotly(p)  

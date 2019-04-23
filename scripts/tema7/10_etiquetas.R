#Labels and legends

library(ggplot2)
tooth <- read.csv("../data/tema7/ToothGrowth.csv")
head(tooth)

#box plot

ggplot(tooth, aes(x=dose, y=len, fill = as.factor(dose)))+
  geom_boxplot()+
  ggtitle("Crecimiento dental en funcion de una dosis de vitamina C")+
  xlab("dosis de vitamina C")+
  ylab("crecimiento dental")+
  labs(fill = "dosis en mg/dia")+
  theme(legend.position = "bottom")+
  guides(fill=F)


#uso de diferentes temas
ggplot(tooth, aes(x=dose, y=len))+
  geom_boxplot()+
  theme_bw()+
  #theme_dark()+
  #theme_classic()+
  #theme_grey()+
  #theme(plot.background = element_rect(fill = "darkblue"))+
  theme(axis.text.x = element_text(face = "bold",
                                   family = "Times",
                                   size = 14,
                                   angle = 45,
                                   color = "#0000FF"),
        axis.text.y = element_text(face = "italic",
                                   family = "Courier",
                                   size = 16,
                                   angle = 30,
                                   color = "#449955")
          )+
          theme(panel.border = element_blank())+
          theme(panel.grid.major = element_blank(),
                  panel.grid.minor = element_blank())

 
                                     
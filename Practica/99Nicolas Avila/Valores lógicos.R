##Operadosres logicos
  
A<-1
B<-2

A<B
A>B
A>=B
A<=B

A==B
A!=B

A<-seq(1,10,by=2)
B<-seq(1,5,by=1)
A
B

A<B
A>B
A==B
A|B

A!=B & A>2

data(iris)
apply(X=iris[,-5], MARGIN=2,FUN=function(x){ ##Para dataframe
  c(Max=max(x),
    Min=min(x),
    Media=mean(x),
    Mediana=median(x),
    Percentil=quantile(x,probs=c(0.25,0.75)))
})

iris[,-5]
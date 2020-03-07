# 数值分析第一次作业

1. 

   1. 为便于算法在计算机上实现，必须将一个数学问题分解为**有限次**的**四则**运算.
   2. 在数值计算中为避免损失有效数字，尽量避免两个**相近的**数作减法运算；为避免误差的扩大，也尽量避免分母的绝对值**远小于**分子的绝对值.
   3. 误差有四大来源，数值分析主要处理其中的**截断误差**和**舍入误差**.
   4. 有效数字越多，相对误差越**小**.

5. 正方形的面积$f(x)=x^2$，则传播误差为

$$
\varepsilon(f(x)) = f'(x)\varepsilon(x)=2x\varepsilon(x)
$$

​		若使$\varepsilon(f(x)) \leq 1$，则有
$$
2 \times 100 \times \varepsilon(x) \leq 1
$$
​		得
$$
\varepsilon(x) \leq 0.005
$$
​		即对正方形边长的测量误差不能超过$0.005$厘米.

6. 设$x$为跑道的测量值，$y$为运动员的成绩，$v$为运动员的速度，跑道的测量误差为
   $$
   \varepsilon(x) = 0.001x
   $$
   则运动员成绩的绝对误差为
   $$
   \varepsilon(y) = \varepsilon(\frac{x}{v})=\frac{1}{v}\varepsilon(x)=0.001\frac{x}{v}=0.001\times60 = 0.06s
   $$
   运动员成绩的绝对误差为
   $$
   \varepsilon_r(y) = \frac{0.06}{60}=0.1\%
   $$
   
7. 由常识知，$4<\sqrt{20}<5$，设$x$有$n$位有效数字，则$x$的相对误差限
   $$
   \varepsilon_r \leq \frac{1}{2\cdot4}\times10^{-n+1} < 0.1\%
   $$
   解得
   $$
   n > 3.10
   $$
   取整得$x$至少拥有$4$位小数.

8.  由于直径$d=3.7$有两位有效数字，故其绝对误差限为
   $$
   \varepsilon(d) = 0.5 \times 10^{-2+1}=0.05
   $$
   则体积的绝对误差限为
   $$
   \varepsilon(V) = \frac{1}{6}\times3\times\pi d^2 \times 0.05 = 1.1
   $$
   相对误差限为
   $$
   \varepsilon_r(V)=\frac{\varepsilon(V)}{V}=\frac{\frac{1}{6}\times 3\pi d^2\times0.05}{\frac{1}{6}\pi d^3}=4.1\%
   $$

11. 

    1. $$
       y = \frac{1}{1+2x}-\frac{1-x}{1+x} (|x| \ll1)
       $$

       $$
       y = \frac{(1+x) - (1-x)(1+2x)}{(1+2x)(1+x)}=\frac{2x^2}{(1+2x)(1+x)}
       $$

    2. $$
       y=\sqrt{x+\frac{1}{x}}-\sqrt{x-\frac{1}{x}}(x\gg 1)
       $$

       $$
       y = \frac{\frac{x^2+1}{x}-\frac{x^2-1}{x}}{\sqrt{\frac{x^2+1}{x}}+\sqrt{\frac{x^2-1}{x}}}=\frac{2}{x(\sqrt{\frac{x^2+1}{x}}+\sqrt{\frac{x^2-1}{x}})}
       $$

    3. $$
       y=\frac{1-cos2x}{x}(|x|\ll 1)
       $$

       $$
       y=\frac{1-cos^2x+sin^2x}{x}=\frac{2sin^2x}{x}
       $$

    4. $$
       sin(x+\varepsilon)-sinx=2cos(\frac{2x+\varepsilon}{2})sin\frac{\varepsilon}{2}
       $$

12. (1) 由$\Delta\approx 55.96427$得方程的两个根$x_1=0.01786, x_2=55.98$，若$x_1$和$x_2$均有四位有效数字，设$\Delta$有$n$位有效数字，则存在下列等式
    $$
    \varepsilon(x_1)=\frac{1}{2}\varepsilon(\Delta)
    $$

    $$
    \varepsilon(x_2)=\frac{1}{2}\varepsilon(\Delta)
    $$

    由定义知
    $$
    \varepsilon(x_1)=\varepsilon_r(x_1)\cdot x_1
    $$

    $$
    \varepsilon(x_2)=\varepsilon_r(x_2)\cdot x_2
    $$

    $$
    \varepsilon(\Delta)=\varepsilon_r(\Delta)\cdot \Delta
    $$

    对于有$n$位有效数字的$\Delta$，有

$$
\varepsilon_r(\Delta)=\frac{1}{2\times5}\times10^{-n+1}=10^{-n}
$$

​       为使$x_1$和$x_2$有四位有效数字，则其相对误差分别为

$$
\varepsilon_r(x_1)=\frac{1}{2}\times 10^{-3}
$$

$$
\varepsilon_r(x_2)=10^{-4}
$$

​	   整理得

$$
10^{-n}\geq \frac{2\varepsilon(x_1)\cdot x_1}{\Delta}
$$

$$
10^{-n}\geq \frac{2\varepsilon(x_2)\cdot x_2}{\Delta}
$$

​	  解以上两个不等式，得$n_1\geq 6.5$和$n_2\geq 3.7$，故$\Delta$至少要取$7$位有效数字.

​	  (2) 若利用 Vieta theorem， 由$x_1=\frac{1}{x_2}$，故仅需取$4$位有效数字算出$x_2$后取倒数即可算出$x_1$.
======= Автономные дифференциальные уравнения на прямой =======

В этой главе мы будем рассматривать дифференциальные уравнения вида

!bt
\begin{equation}
label{eq:2:general}
\dot x = f(t, x),
\end{equation}
!et
где $x\colon D \to \mathbb R$ — неизвестная функция, $D$ — связное подмножство прямой (вся прямая,
луч, отрезок, полуинтервал, интервал), $f\colon D\times \mathbb R\to \mathbb R$
— некоторая по меньшей мере непрерывная (а лучше бы гладкая, как мы увидим чуть
позже) функция от двух переменных.

Напомним, что решением уравнения (ref{eq:2:general}) называется дифференцируемая
функция $\ph$, такая, что выполнено тождество
!bt
\[
\dot \ph(t)=f(t,\ph(t))\quad \forall t \in D
\]
!et
<%doc>
_Поле направлений_:
Вместе с каждым дифференциальным уравнением связано *поле направлений* — картинка, на которой через каждую точку проведена прямая, угловой коэффициент которой равен значению функции $f(t, x)$. Понятно, что такие прямые — это всеовозможные касательные к решениям уравнения.

Приведем пример для дифференциального уравнения $\dot x = t$:

!bc pycod
axes4x4()
rcParams['figure.figsize']=(8,6)
normdirfield(arange(-4,4,0.5),arange(-4,4,0.5),lambda t,x: t,color='red',linewidth=1,length=0.6)
!ec
Даже просто посмотрев на этот график, то видно, что решением этого уравнение должна быть парабола (либо функция, очень похожая на параболу). Синим изображена *интегральная кривая* этого дифференциального уравнения.

!bc pycod
axes4x4()
normdirfield(arange(-4,4,0.5),arange(-4,4,0.5),lambda t,x: t,color='red',linewidth=1,length=0.4)
mplot(linspace(-4,4),lambda x: x**2/2, color='blue')
!ec
Напомним также, как выглядит поле направлений и интегральные кривые для уравнения $\dot x=x$:

!bc pycod
axes4x4()
normdirfield(arange(-4,4,0.5),arange(-4,4,0.5),lambda t,x: x,color='red',linewidth=1,length=0.6)
mplot(linspace(-4,4),lambda t: exp(t), color='blue')
!ec
</%doc>

===== Численное решение дифференциальных уравнений. Метод Эйлера =====
label{sec:2:euler}

## Пусть поставлена ${snippet(u"задача Коши", "cauchy")}:
Пусть поставлена \snref[задача Коши \id cauchy]:
!bt
\begin{equation}
label{eq:2:Cauchy}
\dot x=f(t, x),\quad x(t_0)=x_0.
\end{equation}
!et
Мы можем приблизительно решать её таким образом. Возьмём произвольную точку $(t_0, x_0)$ расширенного фазового пространства. Интегральная кривая, проходящая через эту точку, имеет в ней касательную с угловым коэффициентом $f(t_0, x_0)$. Касательная — это прямая, которая хорошо приближает график функции. Давайте на секундочку представим, что \snref[интегральная кривая\id integral_curve] в точности совпадает с касательной на некотором небольшом промежутке времени — начиная с момента $t_0$ и заканчивая $t_0+\Delta t$, где $\Delta t$ — некоторое маленькое число. Иными словами, мы считаем, что на этом промежутке двигаемся с постоянной скоростью — той, которая была в момент времени $t_0$, то есть $f(t_0, x_0)$. В этом случае к моменту времени $t_0+\Delta t$ мы пройдём расстояние, равное $f(t_0, x_0)\cdot \Delta t$ и попадём в точку $(t_1, x_1)$, задаваемую следующим образом:
!bt
\begin{align*}
x_1&=x_0+f(x_0,t_0)\cdot \Delta t\\\
t_1&=t_0+\Delta t
\end{align*}
!et
Точка $(t_1, x_1)$ лежит на касательной, проходящей через точку $(t_0, x_0)$. Если $\Delta t$ мало, эта точка должна лежать близко к графику настоящего решения. Теперь мы можем взять точку $(t_1, x_1)$ за стартовую, построить в ней уже новую касательную, и пройти по этой касательной ещё на $\Delta t$ вправо. Действуя таким образом, получим набор точек, связанных соотношением:
!bt
\begin{align*}
x_{n+1}&=x_n+f(t_n, x_n)\cdot \Delta t \\\
t_{n+1}&=t_{n}+\Delta t=t_0+(n+1)\Delta t
\end{align*}
!et
Если соединить эти точки отрезками прямых, они будут проходить близко к касательным к графику решения, и сама получающаяся ломаная будет приближаться к настоящему решению. Естественно, с уменьшением шага точность приближения увеличивается.

Этот метод приближённого нахождения решений называется *методом
Эйлера*. Он даёт представление о том, как можно использовать компьютер для
исследования дифференциальных уравнений. На практике, впрочем, используются
более сложные методы, хотя принцип их работы в целом очень схож.

На рис. ref{fig:l02_euler} синим изображено истинное решение уравнения $\dot x = t$ с начальным условием $x(-3)=4$, а красным, розовым, фиолетовым и зеленым изображены численные решения уравнения методом Эйлера 5, 10, 20 и 100 шагами соответственно.
Заметим, что уже сто шагов дает достаточно хорошее приближение решения.

<%
if needfigure("l02_euler"):
    no.axes4x4()
    no.eulersplot(lambda t,x: t, -3, 4, 4, 5, color='red')
    no.eulersplot(lambda t,x: t, -3, 4, 4, 10, color='pink')
    no.eulersplot(lambda t,x: t, -3, 4, 4, 20, color='purple')
    no.eulersplot(lambda t,x: t, -3, 4, 4, 100, color='green')
    no.mplot(no.linspace(-4,4),lambda x: x**2/2-0.5, color='blue')
    savefigs()
%>

${mkfig(u"Приближённые решения")}


##===== {Exercise}: Задача: приближение числа $e$ =====
=== Упражнение ===
Найти число $e$, зная, что функция $x=e^t$ удовлетворяет дифференциальному уравнению $\dot x = x$ и начальному условию $x(0) = 1$.

===== Аналитическое решение автономных дифференциальных уравнений на прямой =====

__Определение.__ *Автономным* называется дифференциальное уравнение, правая
часть которого не зависит от времени явно. Такое уравнение
имеет вид
!bt
\begin{equation}
label{eq:2:auto}
\dot x=f(x)
\end{equation}
!et
##end:def
Рассмотрим задачу Коши для автономного дифференциального уравнения
(ref{eq:2:auto}) с
начальным условием $x(t_0)=x_0$. Пусть $f(x_0)\ne 0$. В этом случае решение задаётся явной формулой (она называется *формулой Барроу*). Мы обсудим несколько способов её вывода и интерпретации.

=== Геометрические соображения ===
В предыдущей главе мы обсуждали, что существует специальный класс дифференциальных
уравнений, которые очень просто решаются: это уравнения вида $\dot x = f(t)$,
мгновенно сводящиеся интегрированию (см. параграф ref{par:1:onlytime}). Мы
будем называть такие уравнения *простейшими*, хотя это не общепринятый термин.

Рассмотрим поля направлений двух уравнений: первое является простейшим, а второе
автономным, см. рис. ref{fig:l2_xt}.
<%
if needfigure("l2_xt", ext="1.exists"):
    no.figure(figsize=(8, 4))
    no.subplot(121)
    no.axes4x4()
    no.normdirfield(no.arange(-4,4,0.5),no.arange(-4,4,0.5),lambda t,x: t,color='red',linewidth=1,length=0.6)
    no.subplot(122)
    no.axes4x4()
    no.normdirfield(no.arange(-4,4,0.5),no.arange(-4,4,0.5),lambda t,x: x,color='red',linewidth=1,length=0.6)
    savefigs()
%>
   
${mkfig(u"Поля направлений для уравнения $\dot x = t$ (слева) и $\dot x = x$ (справа)")}

Это совсем разные уравнения, но их поля направлений обладают неким сходством:
они не меняются при сдвигах. Разница в том, что первое поле направлений не меняется при *вертикальных*
сдвигах, а второе — при *горизонтальных*. Нетрудно понять, что аналогичными
свойствами обладают все уравнения этих двух классов.

Напомним, что задача отыскания решения дифференциального уравнения имеет простую
геометрическую интерпретацию: нужно найти кривую, касающуюся в каждой своей точке
соответствующего поля направлений. Вместе со сходством полей направлений это даёт надежду, что нам удастся придумать метод решения автономных уравнений, сводящий их к некоторым простейшим.

Оказывается, сделать это довольно просто: достаточно поменять роль осей и
считать независимой переменной $x$, а неизвестной функцией — время. Ниже мы
обсудим два способа реализации этого замысла.

=== Механический подход ===
label{par:2:mech}

Решить дифференциальное уравнение — это значит научиться отвечать на вопрос о
том, где окажется решение в произвольный момент времени $t$, если в момент
времени $t_0$ оно находилось в точке $x_0$. В соответствии с
выводами предыдущего пункта, поменяем роли переменных и зададим другой вопрос:
сколько времени потребуется, чтобы добраться из точки $x_0$ до некоторой другой точки
$x$? 

Попробуем ответить на этот вопрос (хотя бы приближённо) с помощью аналога метода
Эйлера (см. раздел ref{sec:2:euler}). Предположим для определённости, что
$x>x_0$ и $f(x_0)>0$ (вблизи $x_0$ движение происходит вправо; обратный случай
рассматривается полностью аналогично). Предположим также, что на всём отрезке
$[x_0, x]$ функция $f$ принимает только положительные значения (чуть ниже мы обсудим, что это вполне разумное предположение). Разобьем отрезок $[x_0, x]$ на $n$ равных маленьких отрезочков длины $\Delta x$. Пусть $x_k = x_0 + k\cdot \Delta x$ — концы наших отрезочков. Сколько времени нужно, чтобы попасть из точки $x_k$ в точку $x_{k+1}$? Для этого нам придётся пройти расстояние, равное $\Delta x$. Мгновенная скорость движения в точке $x_k$ равна $f(x_k)$. Поскольку $\Delta x$ мало, а функция $f$ непрерывна, можно ожидать, что её значение не слишком сильно изменится, по крайней мере, пока мы находимся на том же отрезочке. Значит можно считать (совершая некоторую ошибку, малую при малых $\Delta x$), что движение на всём отрезочке происходит с постоянной скоростью, равной $f(x_k)$. Тогда время движения вычисляется по школьной формуле: нужно расстояние $\Delta x$ поделить на скорость $f(x_k)$. Обозначим вычисленное таким образом время прохождения $k$-го отрезочка через $\Delta t_k$. Имеем:

!bt
\begin{equation}
label{eq:2:Delta_t}
\Delta t_k = \frac{\Delta x}{f(x_k)}
\end{equation}
!et
Пусть мы оказались в точке $x$ в момент времени $t$. Тогда время прохождения всего отрезка от $x_0$ до $x$ равна $t-t_0$ и получается сложением всех
$\Delta t_k$ для $k=0, \ldots, n-1$:
!bt
\begin{equation}
label{eq:2:T}
t-t_0 \approx \sum_{k=0}^{n-1} \Delta t_k = \sum_{k=0}^{n-1} \frac{1}{f(x_k)}\Delta
x
\end{equation}
!et
Ну-ка, что у нас тут в правой части? Это же интегральные суммы для функции
$\frac{1}{f(x)}$! Равенство (ref{eq:2:T}) является приближённым, но когда мы
перейдём к
пределу при $\Delta x \to 0$ (или, что то же самое, при $n\to \infty$), оно
превратится в точное:
!bt
\begin{equation}
label{eq:2:Barrow}
t-t_0 = \int_{x_0}^x \frac{dy}{f(y)}.
\end{equation}
!et
Это соотношение и назвается формулой Барроу. Его можно понимать как неявное выражение $x$ через $t$. В некоторых ситуациях из него можно выразить функцию $x(t)$ явно.

=== Аналитический подход ===
Приведём более формальный вывод формулы Барроу, опирающийся на математический
анализ.  Пусть функция $x=\ph(t)$ является решением уравнения (ref{eq:2:auto}) и удовлетворяет начальному условию $\ph(t_0)=x_0$. Рассмотрим функцию $t=\psi(x)$, обратную к функции $x=\ph(t)$.  Рассмотрим произвольную точку $(t_1, x_1)$, лежащую на графике решения: для неё выполняются соотношения $x_1 = \ph(t_1)$, $t_1 = \psi(x_1)$ и $\dot \ph(t_1)=f(x_1)$ (поскольку $\ph$ является решением уравнения). Тогда по теореме о производной сложной функции

!bt
\[
\psi'(x_1)=\frac{d\psi(x_1)}{dx}=\frac{1}{\dot \ph(t_1)}=\frac{1}{f(x_1)}
\]
!et
Это равенство выполняется в любой точке $x_1$. Значит, функция $\psi$ является решением дифференциального уравнения
!bt
\[
\psi'(x)=\frac{1}{f(x)},
\]
!et
где $x$ выступает в роли независимой переменной. Правая часть теперь не зависит от неизвестной функции и такое уравнение мы умеем решать:
!bt
\[
\psi(x)=\int_{x_0}^x \frac{dy}{f(y)}+t_0
\]
!et
Вспоминая, что $t=\psi(x)$ — обратная функция к решению $x=\ph(t)$, имеем:
!bt
\[
t-t_0=\int_{x_0}^{\ph(t)} \frac{dy}{f(y)}
\]
!et
Мы снова получили формулу Барроу.

Часто используют такую символическую запись:

!bt
\begin{align}
\dot x&=f(x)\\
\frac{dx}{dt}&=f(x)\\
label{eq:2:magic}
dt & =\frac{dx}{f(x)}\\
label{eq:2:int}
\int_{t_0}^t dt&= \int_{x_0}^x \frac{dx}{f(x)}
\end{align}
!et
Это может показаться некоторой магией — особенно загадочно выглядит уравнение (ref{eq:2:magic}). Чуть позже мы дадим определение *дифференциальной 1-формы*, с помощью которого можно придать этим формулам аккуратный смысл, а пока обратим внимание, что уравнение (ref{eq:2:magic}) очень похоже на уравнение (ref{eq:2:Delta_t}). В целом, эта формальная запись фактически повторяет наш вывод в параграфе ref{par:2:mech}.

=== Пример ===
Решим уравнение $\dot x=x$ с начальным условием $x(t_0)=x_0$. Пусть $x=\ph(t)$ —
решение и $t=\ph^{-1}(x)$ — обратная функция к решению. Имеем:

!bt
\begin{align*}
(\ph^{-1}(x))'&=\frac{1}{x}\\
\ph^{-1}(x) &= \psi (x)\\
\psi' (x)  &= \frac 1 x\\
\psi (x) &= \int \frac{dx} x = \ln |x| + C\\
t&=\ln|x|+C\\
x &= \pm e^{-C}e^t = C_1 e^t
\end{align*}
!et
Заметим, что если бы мы забыли модуль под логарифмом при интегрировании, то константа $C_1=e^{-C}$ принимала бы только положительные значения. Но из-за модуля она может принимать и отрицательные значения.
Заметим также, что в ходе преобразований (деления на $x$) мы «потеряли» решение $x=0$. Если в ответ подставить значение $C_1=0$, получим как раз его. Таким образом, формула $x(t)=Ce^t$, $C\in \mathbb R$ даёт все известные нам решениям. Мы пока не доказали, что других нет — на следующей лекции мы обсудим этот вопрос.

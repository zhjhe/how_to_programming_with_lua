# Chapter 1 用函数做抽象

## 1.1 程序设计的基本元素

一个强有力的程序设计语言，不仅是一种指挥计算机执行任务的方式，它还应该成为一种框架，使我们能够在其中组织自己有关计算过程的思想。

因此我们在学习编程语言时，就需要将注意力特别放在语言如何将简单的认识组合起来形成更复杂认识的方法上。

一般来说，每一种强力的编程语言都为此提供了三种机制：

    1. 基本表达形式：用于表示语言所关心的最简单的个体；
    2. 组合的方法：通过它们可以从比较简单的东西出发构造出复合的元素；
    3. 抽象的方法：通过它们可以为复合对象命名，并将它们当作单元去输出。

### 1.1.1 表达式

```lua
3           --  基本表达式，整数
"hello"     -- 基本表达式，字符串
true        -- 基本表达式，布尔量

3 + 3       -- 用表示基本过程的表达形式（例如+），将表示数的表达式组合起来，形成复合表达式，称之为组合式
5 - 2
2 * 2
10 / 2
3 * 5 * (10 - 6)
```

### 1.1.2 命名和环境

我们需要通过一种通过名字去使用计算对象的方式。比如我们需要计算圆的周长和面积，都要使用到 pi， 那么我们无需每次都输入 3.1415926 这个数字，而是使用 pi 这个名字来代表它。我们将名字标识符称为变量，它的值也是就是它对应的那个对象。

```lua
local pi = 3.14
local r = 10.0
local c= 2 * pi * r
local a= pi * r * r

local width = 3
local height = 4

local perimeter = 2 * width + 2 * height
local area = 2 * width * height
```

    可选内容：
        组合式的求值规则

### 1.1.3函数(复合过程)

我们已经看到了编程语言中的三种元素：

    - 数和算术运算是基本的数据过程；
    - 组合式的嵌套提供了一种组织起多个操作的方法；
    - 给变量命名是一种受限的抽象手段，通过赋值让名字和值关联起来。

现在我们来看函数定义。这是一种威力更加强大的抽象技术，通过它可以为复合操作提供名字，而后就可以将这样的操作作为一个单元来使用了。

以平方为例，我们的意思是：某个东西的平方，就是它自身乘以自身。

```lua
function square(x)
    return x * x
end

function sum_of_square(x, y)
    return square(x) + square(y)
end
```

定义好 square 之后，我们就可以使用它了。

函数作为一种抽象技术，关键点在于定义完之后，就可以把它作为单元使用。对于使用者来说，无需关心函数是怎样定义的，可以把它作为一个黑盒来使用。

函数的名称，输入、输出的定义要仔细选择，对于使用者来说，这是他需要关心的，其它的则不需要关心了。

这也是构建复杂系统的方法之一，我们可以通过抽象，抛开那些不需要花费精力思考的细节，在某个时刻，我们仅仅思考必要的东西，这样就能对整体有一个很好的把握。

然后我们还可以把 square 作为基本构建去定义其它函数。

    可选内容：
    代换模型和求值序

### 1.1.4 条件判断

到现在，我们编程的表达能力还非常有限，因为没办法做某些检测，然后根据检测的结果去确定做不同的动作。比如我们甚至还没法计算一个数的绝对值。

这种结构称为分情况讨论。Lua 提供了 if 语句来实现它：

```lua
function abs(x)
    if x > 0 then
        return x
    else
        return -x
```

if 后边必须着一个被求值为 bool 类型的表达式。如果表达式的值为 true，就（then）执行后面的语句。

一些基本的过程可以产生 bool 值，比如 < = > 。

除此之外，还可以有 and 、or、和 not。

### 练习

#### 1.1

请定义一个函数，它以三个整数为参数，返回其中较大的两个数之和。

### 1.1.5 例子：采用牛顿法求平方根

前面的例子也许太简单，读者也许已经觉得无聊到昏昏欲睡了，所以现在我们来写点真正能发挥计算机威力的程序。

考虑求平方根的问题。假设x的平方根为y，那么有 y^2 = x。

但是，这只是一个定义，从这里我们无法写出一个程序来求 x 的平方根。

如何描述一件事情的特征，与描述如何去做这件事情往往有较大的差异。换一种说法，前者是说明性知识，而后者是行动性知识。过去我们认知到的知识都是说明性的，但在写程序时，我们更关心行动性的描述。

    （额外的话：由于编写程序迫使我们以行动性的观点考察世界，因此可以培养我们另外一种思维，和描述性知识结合起来，可以增强我们的智力）


计算机如何算出平方根呢？最常用的方法就是牛顿的逐步逼进方法。这种方法说，如果对x的平方根的值有了一个猜测y，那么就可以通过执行一个简单操作去得到一个更好的猜测：只需要求出 y 和 x/y 的平均值。例如，可以用这种方式来计算2的平方根，假定以 1.0 开始作为猜测。

| 猜测   | 商     | 平均值 |
| ------ | ------ | ------ |
| 1.0    | 2/1=2  | 1.5    |
| 1.5    | 1.3333 | 1.4167 |
| 1.4167 | 1.4118 | 1.4142 |
| 1.4142 | ...    | ...    |

仔细看一下这个过程，用自然语言描述如下：

    1. 输入一个猜测值 y 和 x，希望 y 是 x 的平方根，
    2. 检测y是否足够好；
    3. 如果步骤2检测通过，则猜测值 y 就是所要的结果，返回它；
    4. 如果步骤检测未通过，那么就通过求 y 和 x/y 的平均值，得到一个新的猜测值 next y；
    5. 重复这一过程；

接下来我们用编程语言把它写出来。

```lua
local function improve(guess, x)
    return (guess + x / guess) / 2
end

local function is_good_enough(guess, x)
    return math.abs(guess * guess - x) < 0.001
end

local function sqrt_iter(guess, x)
    if is_good_enough(guess, x) then
        return guess
    else
        local next_guess = improve(guess, x)
        return sqrt_iter(next_guess, x)
    end
end

local function sqrt(x)
    return sqrt_iter(1.0, x)
end

print(sqrt(9))
```

### 练习

#### 1.2

### 1.1.6 函数作为黑盒抽象

函数作为一个过程应该能隐藏一些细节。使用者可能无需自己去写这些过程，而是从其它地方作为一个黑盒来接受了它。用户在使用一个函数时，应该不需要去弄清楚它是怎样实现的。

    例如上面的过程中，我们直接使用了 Lua 的 math 库中的 abs 函数，我们并不关心它是怎么实现的。

## 1.2 过程和它们产生的计算（可选内容）

如同下棋，我们必须明白当我们走出一步后，会发生什么事情，我们才可以决定该怎么走。对于编程来说，我们需要通过阅读代码语句来明了背后会发生什么样的计算，这样我们才能知道该怎么写代码语句。

### 1.2.1 线性的递归和迭代

考虑一个计算阶乘的例子。阶乘的数据定义是：

    n!=n * (n-1) * (n-2)··· 3 * 2 * 1

这是一个描述性知识，必须想办法改成行动性才能写出代码来。

#### 线性递归计算过程

有很多种行动方法可以计算阶乘，最简单的可能是下面这种：

    fact(n) = n * fact(n-1)
    fact(0) = 1

```lua
function fact(n)  
    if n == 1 then
        return 1
    else
        return n * fact(n-1)
end
 ```

如果我们使用代换模型来展开它，就可以得到一个线性递归的形状。

仔细观察这个过程，它先逐步展开然后收缩。

在展开阶段，它构造起一个推迟进行的操作所形成的链条。

在收缩阶段，它表现为这些运算的实际执行。

这种类型的计算过程由一个推迟执行的运算链条刻画，称为一个递归计算过程。

要执行这种计算过程，需要维护好那些以后将要执行的操作的轨迹。在计算阶乘时，推迟执行的乘法链条的长度就是为保存轨迹需要保存的信息量，这个长度随着n值线性增长。

#### 线性迭代计算过程

现在使用另外一种观点来计算阶乘。（要稍微麻烦一点）

    先用1乘2，然后将得到的结果乘3，而后乘4，一直这样做下去直到达到n。

用形式化的语言描述就是：

有一个乘积 product，以及一个从1到n的计数器，在这个计算过程中，从当前步到下一步，按如下规则变动：

    product <-  counter * product
    counter <-  counter + 1

那么，n!就是 counter 超过 n 时  product 的值。

观察这个过程，期间没有任何增长或收缩。对于任何一个n，在计算过程中的每一步，在我们需要保存的轨迹里，所有的东西就是三个变量的当前值。我们称这种过程为一个迭代计算过程。

    思考：sqrt 是哪一种计算过程？

要特别注意区别递归计算过程和递归过程的概念。

我们已经看到，一个递归过程也可能产生一个迭代计算过程。

### 练习

#### 1.3

定义一个幂函数，可以求出 x 的 n 次幂。

### 1.2.2 树形递归

另外一种常见计算模式称为树形递归。作为例子，考虑 Fibonacci 数序列的计算。

    0， 1， 1， 2， 3， 5， 8， 13， 21...

根据递归定义，可以马上翻译为一个递归函数。

```lua
function fib(n)
    if n == 0 then return 0
    elseif n == 1 then return 1
    else return fic(n-1) + fib(n-2) end
end
```

观察 Fibonacci 的执行过程，可以看到外形像一颗树。

当 n 比较大时，执行过程肉眼可见的变慢。这是因为执行了大量重复的计算。可以思考一下可以怎样优化一下，快速解决n较大时的计算情况。

### 练习

#### 1.4

换零钱方式的统计。人民币有1元、2元、10元的纸币，现在需要100元换成零钱，一共有多少种不同的方式？更一般的问题是：给定任意数量的现金，我们能写一个程序，计算出所有换零钱方式的种数吗？（这个问题有一定的难度，尤其如果你想用迭代的方式解决的话）

#### 1.5

最大公约数。给定两个整数，求它们的最大公约数。

#### 1.6

检测一个数是否为素数。（注意，我们现在还没有介绍 Lua 的迭代语法）

### 1.3 用高阶过程（函数）做抽象

我们已经看到，从作用上看，过程（函数）也就是一类抽象，它们描述了一些对于数的复合操作，但又并不依赖于特点的数。比如下面这个定义：

```lua
function cube(x)
    return x * x * x
end
```

我们讨论的不是某个特定数值的立方，二十对任意的数得到其立方的方法。

当然，我们也完全可以不定义这个函数，而总是写下面的表达式：

3*3*3
y*y*y

不明确提出 cube。但这样就会把自己置入一个非常糟糕的境地，我们将永远在语言恰好提供的那些特定基本操作的层面工作，而不能基于更高级的操作去工作。我们的程序的确计算了立方，但不能表述“立方”这一概念。

因此，功能强的程序设计语言必须可以为公共的模式命名，建立抽象，而后直接在抽象的层次上工作。 Lua 的函数就提供了这种能力。这也是为什么任何一种编程语言都会提供类似的定义过程的机制。

```lua
local cube = function (x)
    return x * x * x
end
```

然而，即便是数值计算这么简单的任务，如果过程的参数只能是数，那也会严重地限制我们建立抽象的能力。经常有一些同样的程序设计模式能用于若干不同的过程。为了把这种模式描述为相应的概念，我们就需要构造出这样的过程：让它们以过程作为参数，或者以过程作为返回值。这类能操作过程的过程成为高阶过程。接下来我们看几个例子，以了解高阶过程如何能成为强大的抽象机制，极大地增强语言的表达能力。

#### 1.3.1 过程作为参数

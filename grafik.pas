program grafik;
const
    eps = 0.000001;
    a1 = -10;
    b1 = -1;
    a2 = 1;
    b2 = 10;

type
    fun = function(x: real): real;

var
    x, x1, x2, x3, x4, x5, x6, s, s1, s2, s3, s4, s5, s6, out: real;
    flag: char;
    n: integer;

function f(x: real): real;
    begin
        f:= 0.6*x + 3
    end;

function g(x: real): real;
    begin
        g:= (x-2)*(x-2)*(x-2) - 1
    end;

function h(x: real): real;
    begin
        h:= 3/x
    end;

function o(x: real): real;
    begin
        o:= 0
    end;

function t(x: real): real;
    begin
        t:= 3
    end;

function Chord(f1, f2: fun; a, b: real): real;
  Begin
    Chord := ((f1(b) - f2(b))*a - (f1(a) - f2(a))*b) / ((f1(b) - f2(b)) - (f1(a) - f2(a)))
  End;

procedure root(var flag: char; var out: real; f1, f2: fun; a, b: real);
    var
        c: real;
    begin
        repeat
            c := Chord(f1, f2, a, b); 
            if (f1(a) - f2(a)) * (f1(c) - f2(c)) > 0 
                        then a := c
            else b := c;
            if flag <> '-' then
                writeln(a, ' ', b, ' ', c);
        until abs(Chord(f1, f2, a, b) - c) < eps;
        if flag <> '-' then
            writeln(Chord(f1, f2, a, b));
        out := c;
    end;

procedure integral(var flag: char; var out: real; f: fun; a, b: real);
    var 
        n, i, iter: integer; 
        h1, In1, In2, fm, ft, fa, fb: real;
        
    begin
        n := 4;
        fa := f(a);
        fb := f(b);
        fm := f((b-a)/2);
        In2 := ((b-a)/6)*(f(a)+4*fm+f(b));
        iter := 1;
        repeat
            In1 := In2;
            In2 := fm*2 + fa + fb;
            h1 := (b-a)/n;
            i := 1;
            while i < n do 
                begin
                    ft := f(a + i*h1);
                    fm := fm+ ft;
                    In2 := In2 + 4*ft;
                    i := i + 2;
                end;
            In2 := In2*(h1/3);
            n := n*2;
            if flag <> '-' then
                writeln('  ', iter, '. ', In2:8:4);
            iter := iter + 1;  
        until abs(In1-In2)/15 < eps;
        out := abs(In2);
        if flag <> '-' then
            begin
                writeln('  Потребовалось ', iter-1, ' итераций');
                writeln('  Кол-во разбиений: ', n);
            end;
    end;

begin
    writeln('Запустить тестовый режим? (+/-)');
    read(flag);
    if flag = '-' then
        begin
            root(flag, out, f, h, a1, b1);
            x1 := out;
            root(flag, out, f, o, a1, b1);
            x2 := out;
            root(flag, out, g, h, a1, b1);
            x3 := out;
            root(flag, out, f, h, a2, b2);
            x4 := out;
            root(flag, out, g, o, a2, b2);
            x5 := out;
            root(flag, out, g, h, a2, b2);
            x6 := out;

            writeln('1 Точка пересечения функций f и h: ', x1:8:4);
            writeln('Точка пересечения функций f и оси x : ', x2:8:4);
            writeln('1 Точка пересечения функций g и h : ', x3:8:4);
            writeln('2 Точка пересечения функций f и h: ', x4:8:4);
            writeln('Точка пересечения функций f и оси x : ', x5:8:4);
            writeln('2 Точка пересечения функций g и h: ', x6:8:4);

            writeln('');

            integral(flag, out, h, x1, x3);
            s1:= out;
            integral(flag, out, f, x2, x4);
            s2:= out;
            integral(flag, out, f, x1, x2);
            s3:= out;
            integral(flag, out, g, x3, x5);
            s4:= out;
            integral(flag, out, h, x4, x6);
            s5:= out;
            integral(flag, out, g, x5, x6);
            s6:= out;

            writeln('Площадь под графиком функции h на отрезке [', x1:8:4, ', ', x3:8:4, '] равна ', s1:8:4);
            writeln('Площадь под графиком функции f на отрезке [', x2:8:4, ', ', x4:8:4, '] равна ', s2:8:4);
            writeln('Площадь под графиком функции f на отрезке [', x1:8:4, ', ', x2:8:4, '] равна ', s3:8:4);
            writeln('Площадь под графиком функции g на отрезке [', x3:8:4, ', ', x5:8:4, '] равна ', s4:8:4);
            writeln('Площадь под графиком функции h на отрезке [', x4:8:4, ', ', x6:8:4, '] равна ', s5:8:4);
            writeln('Площадь под графиком функции g на отрезке [', x5:8:4, ', ', x6:8:4, '] равна ', s6:8:4);

            s:= s1 + s2 - s3 + s4 + s5 - s6;

            writeln('Площадь фигуры равна ', s:8:4);
        end
    else
        begin
            //root(flag, out, f, h, -8, -4);
            //integral(flag, out, o, a2, b2);
            //integral(flag, out, f, -10, -5);
            integral(flag, out, h, -5, -1);
            writeln(out);
        end;
end.
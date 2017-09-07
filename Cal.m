classdef Cal
    methods(Static)
        function Pws = CalPws(Ta)
            %求给定温度下饱和水蒸气压力
            Ta = 273.15 + Ta;
            c1 = -5.6745359e3;
            c2 = 6.3925247;
            c3 = -9.677843e-3;
            c4 = 6.2215701e-7;
            c5 = 2.0747825e-9;
            c6 = -9.484024e-13;
            c7 = 4.1635019;
            c8 = -5.8002206e3;
            c9 = 1.3914993;
            c10 = -4.8640239e-2;
            c11 = 4.1764768e-5;
            c12 = -1.4452093e-8;
            c13 = 6.5459673;
            if Ta < 273.15
                Pws = exp(c1 / Ta + c2 + c3 * Ta + c4 * Ta ^ 2 + c5 * Ta ^ 3 + c6 * Ta ^ 4 + c7 * log(Ta));
            else
                c8 / Ta + c9 + c10 * Ta + c11 * Ta ^ 2 + c12 * Ta ^ 3 + c13 * log(Ta)
                Pws = exp(c8 / Ta + c9 + c10 * Ta + c11 * Ta ^ 2 + c12 * Ta ^ 3 + c13 * log(Ta));
            end
        end
        function Pws=CalPwsByRHPa(RH,Pa)
            Pws=Pa/(RH/100);
        end
        function Pa=CalPaByRH(RH,Pws)
            Pa=RH/100*Pws;
        end
        function Pa=CalPaByd(d,B)
            Pa=(B*d)/(d+621.945);
        end
        function d=CaldByPa(Pa,B)
            d=621.945*Pa/(B-Pa);
        end
        function d=CaldByTaTw(Ta,Tw,B)
            %已知干湿球温度求d
            dw=Cal.CaldByTd(Tw,B)/1000;
            if Ta>=0
                d=((2501-2.326*Tw)*dw-1.006*(Ta-Tw))/(2501+1.86*Ta-4.186*Tw);
            else
                d=((2830-0.24*Tw)*dw-1.006*(Ta-Tw))/(2830+1.86*Ta-2.1*Tw);
            end
            d=d*1000;
        end
        function d=CaldByTd(Td,B)
            Pws=Cal.CalPws(Td);
            d=Cal.CaldByPa(Pws,B);
        end
        function d=CaldByTah(Ta,h)
            d=(h-1.006*Ta)/(2501+1.86*Ta)*1000;
        end
        function d=CaldByTarou(Ta,rou,B)
            Ta = Ta + 273;
            d=-(-0.287042*Ta+B/(1000*rou))/(-0.287042*1.607858*0.001*Ta);
        end
        function RH=CalRHByPaPws(Pa,Pws)
            RH=Pa/Pws*100;
        end
        function h=CalhByTad(Ta,d)
            h=1.006*Ta+0.001*d*(2501+1.86*Ta);
            %参考ASHRAE Handbook
        end
        function rou=CalrouByTad(Ta, d, B)
            rou = B/(1000*0.287042 *(Ta+273.15)* (1 + 1.607858 * d * 0.001));
            %参考ASHRAE Handbook          
        end
        function Td=CalTd(Pa)
            %求露点温度
            Pa = Pa / 1000;
            c1 = 6.54;
            c2 = 14.526;
            c3 = 0.7389;
            c4 = 0.09486;
            c5 = 0.4569;
            a = log(Pa);
            t1 = c1 + c2 * a + c3 * a ^ 2 + c4 * a ^ 3 + c5 * Pa ^ (0.1984);
            if t1 >= 0
                Td = t1;
            else
                Td = 6.09 + 12.608 * a + 0.4959 * a ^ 2;
            end
        end
        function Tw=CalTwByTad(Ta,d,B)
            Tw=Ta;
            dT=0.001;
            x=100;
            iteration=0;
            Maxiteration=100;
            while abs(x)>1e-4&&iteration<Maxiteration
                f1=Cal.CaldByTaTw(Ta,Tw,B);
                f2=Cal.CaldByTaTw(Ta,Tw+dT,B);
                x=dT*(f1-d)/(f2-f1);
                Tw=Tw-x;
                iteration=iteration+1;
            end
        end 
        function Ta=CalTaByRHd(RH,d,B)
            Pa=Cal.CalPaByd(d,B);
            Pws=Pa/(RH/100);
            Ta=Cal.CalTd(Pws);
        end
        function Ta=CalTaByRHh(RH,h,B)
            Ta=25;
            dT=0.001;
            x=100;
            iteration=0;
            Maxiteration=1000;
            while abs(x)>1e-4&&iteration<Maxiteration   
                f1=Cal.CalPaByd(Cal.CaldByTah(Ta,h),B)/Cal.CalPws(Ta)*100;
                f2=Cal.CalPaByd(Cal.CaldByTah(Ta+dT,h),B)/Cal.CalPws(Ta+dT)*100;
                x=dT*(f1-RH)/(f2-f1);
                Ta=Ta-x;
                iteration=iteration+1;
                if f1<0||f2<0
                    Ta=-60;
                end
            end
        end
        function Ta=CalTaByRHTw(RH,Tw,B)
            Ta=20;
            dT=0.001;
            x=100;
            iteration=0;
            Maxiteration=100;
            while abs(x)>1e-4&&iteration<Maxiteration
                f1=Cal.CalPaByd(Cal.CaldByTaTw(Ta,Tw,B),B)/Cal.CalPws(Ta)*100;
                f2=Cal.CalPaByd(Cal.CaldByTaTw(Ta+dT,Tw,B),B)/Cal.CalPws(Ta+dT)*100;
                x=dT*(f1-RH)/(f2-f1);
                Ta=Ta-x;
                iteration=iteration+1;
            end
        end
        function Ta=CalTaByPws(Pws)
            Ta=Cal.CalTd(Pws);
        end
        function Ta=CalTaByRHrou(RH,rou,B)
            Ta=20;
            dT=0.001;
            x=100;
            iteration=0;
            Maxiteration=100;
            while abs(x)>1e-4&&iteration<Maxiteration
                f1=Cal.CalPaByd(Cal.CaldByTarou(Ta,rou,B),B)/Cal.CalPws(Ta)*100;
                f2=Cal.CalPaByd(Cal.CaldByTarou(Ta+dT,rou,B),B)/Cal.CalPws(Ta+dT)*100;
                x=dT*(f1-RH)/(f2-f1);
                Ta=Ta-x;
                iteration=iteration+1;
            end
        end
        function Ta=CalTaBydh(d,h)
            Ta=(h-0.001*d*2501)/(1.006+0.001*d*1.86);
        end
        function Ta=CalTaBydTw(d,Tw,B)
            dw=Cal.CaldByTd(Tw,B)/1000;
            d=d/1000;
                Ta=((2501-2.326*Tw)*dw+1.006*Tw-d*(2501-4.186*Tw))/(1.006+1.86*d);
            if Ta<0
                Ta=((2830-0.24*Tw)*dw+1.006*Tw-d*(2830-2.1*Tw))/(1.006+1.86*d);
            end
        end
        function Ta=CalTaBydrou(d,rou,B)
            Ta= B/(rou*1000*0.287042 * (1 + 1.607858 * d * 0.001))-273.15;
        end
        function Ta=CalTaByhTw(h,Tw,B)
            Ta=20;
            dT=0.001;
            x=100;
            iteration=0;
            Maxiteration=100;
            while abs(x)>1e-4&&iteration<Maxiteration
                f1=Cal.CaldByTaTw(Ta,Tw,B)-Cal.CaldByTah(Ta,h);
                f2=Cal.CaldByTaTw(Ta+dT,Tw,B)-Cal.CaldByTah(Ta+dT,h);
                x=dT*f1/(f2-f1);
                Ta=Ta-x;
                iteration=iteration+1;
            end
            
        end
        function Ta=CalTaByhrou(h,rou,B)
            Ta=20;
            dT=0.001;
            x=100;
            iteration=0;
            Maxiteration=100;
            while abs(x)>1e-4&&iteration<Maxiteration
                f1=Cal.CaldByTah(Ta,h)-Cal.CaldByTarou(Ta,rou,B);
                f2=Cal.CaldByTah(Ta+dT,h)-Cal.CaldByTarou(Ta+dT,rou,B);
                x=dT*f1/(f2-f1);
                Ta=Ta-x;
                iteration=iteration+1;
            end
        end
    end
end


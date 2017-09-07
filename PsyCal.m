classdef PsyCal
    %PsychrometricCalculator 
    properties
        B;
        Ta;
        RH;
        d;
        h;
        Td;
        Tw;
        Pws;
        Pa;
        rou;   
    end
    methods
        function obj=PsyCal(Tp,x1,x2,B)
            if nargin==4
                obj.B=B;
            else
                obj.B=101325;
            end
            switch char(Tp)
                case 'TaRH'
                    obj.Ta=x1;
                    obj.RH=x2;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByRH;
                    obj.d=obj.CaldByPa;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;
                    obj.Tw=obj.CalTwByTad;
                case 'TaTw'
                    obj.Ta=x1;
                    obj.Tw=x2;
                    obj.d=obj.CaldByTaTw;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;
                case 'Tad'
                    obj.Ta=x1;
                    obj.d=x2;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd; 
                case 'Tah'
                    obj.Ta=x1;
                    obj.h=x2;
                    obj.d=obj.CaldByTah;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd; 
                case 'TaTd'
                    obj.Ta=x1;
                    obj.Td=x2;
                    obj.d=obj.CaldByTd;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                case 'TaPa'
                    obj.Ta=x1;
                    obj.Pa=x2;
                    obj.d=obj.CaldByPa;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;   
                case 'Tarou'
                    obj.Ta=x1;
                    obj.rou=x2;
                    obj.d=obj.CaldByTarou;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.Td=obj.CalTd;
                case 'RHd'
                    obj.RH=x1;
                    obj.d=x2;
                    obj.Ta=obj.CalTaByRHd;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;
                case 'RHh'
                    obj.RH=x1;
                    obj.h=x2;
                    obj.Ta=obj.CalTaByRHh;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByRH;
                    obj.d=obj.CaldByPa;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;
                    obj.Tw=obj.CalTwByTad; 
                case 'RHTd'
                    obj.RH=x1;
                    obj.Td=x2;
                    obj.d=obj.CaldByTd;
                    obj.Ta=obj.CalTaByRHd;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                case 'RHTw'
                    obj.RH=x1;
                    obj.Tw=x2;
                    obj.Ta=obj.CalTaByRHTw;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByRH;
                    obj.d=obj.CaldByPa;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;
                case 'RHPws'
                    obj.RH=x1;
                    obj.Pws=x2;
                    obj.Ta=obj.CalTaByPws;
                    obj.Pa=obj.CalPaByRH;
                    obj.d=obj.CaldByPa;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;
                    obj.Tw=obj.CalTwByTad;  
                case 'RHPa'
                    obj.RH=x1;
                    obj.Pa=x2;
                    obj.Pws=obj.CalPwsByRHPa;
                    obj.Ta=obj.CalTaByPws;
                    obj.d=obj.CaldByPa;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;
                    obj.Tw=obj.CalTwByTad;
                case 'RHrou'
                    obj.RH=x1;
                    obj.rou=x2;
                    obj.Ta=obj.CalTaByRHrou;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByRH;
                    obj.d=obj.CaldByPa;
                    obj.h=obj.CalhByTad;
                    obj.Td=obj.CalTd;
                    obj.Tw=obj.CalTwByTad;
                case 'dh'
                    obj.d=x1;
                    obj.h=x2;
                    obj.Ta=obj.CalTaBydh;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd; 
                case 'dTw'
                    obj.d=x1;
                    obj.Tw=x2;
                    obj.Ta=obj.CalTaBydTw;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;
                case 'dPws'
                    obj.d=x1;
                    obj.Pws=x2;
                    obj.Ta=obj.CalTaByPws;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd; 
                case 'drou'
                    obj.d=x1;
                    obj.rou=x2;
                    obj.Ta=obj.CalTaBydrou;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.Td=obj.CalTd; 
                case 'hTd'
                    obj.h=x1;
                    obj.Td=x2;
                    obj.d=obj.CaldByTd;
                    obj.Ta=obj.CalTaBydh;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.rou=obj.CalrouByTad;
                case 'hTw'
                    obj.h=x1;
                    obj.Tw=x2;
                    obj.Ta=obj.CalTaByhTw;
                    obj.d=obj.CaldByTah;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd; 
                case 'hPws'
                    obj.h=x1;
                    obj.Pws=x2;
                    obj.Ta=obj.CalTaByPws;
                    obj.d=obj.CaldByTah;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd; 
                case 'hPa'
                    obj.h=x1;
                    obj.Pa=x2;
                    obj.d=CaldByPa(obj);
                    obj.Ta=obj.CalTaBydh;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.RH=obj.CalRHByPaPws;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;    
                case 'hrou'
                    obj.h=x1;
                    obj.rou=x2;
                    obj.Ta=obj.CalTaByhrou;
                    obj.d=obj.CaldByTah;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.Td=obj.CalTd; 
                case 'TdTw'
                    obj.Td=x1;
                    obj.Tw=x2;
                    obj.d=obj.CaldByTd;
                    obj.Ta=obj.CalTaBydTw;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                case 'TdPws'
                    obj.Td=x1;
                    obj.Pws=x2;
                    obj.d=obj.CaldByTd;
                    obj.Ta=obj.CalTaByPws;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                case 'Tdrou'
                    obj.Td=x1;
                    obj.rou=x2;
                    obj.d=obj.CaldByTd;
                    obj.Ta=obj.CalTaBydrou;
                    obj.Tw=obj.CalTwByTad;
                    obj.Pws=obj.CalPws;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                case 'TwPws'
                    obj.Tw=x1;
                    obj.Pws=x2;
                    obj.Ta=obj.CalTaByPws;
                    obj.d=obj.CaldByTaTw;
                    obj.Pa=obj.CalPaByd;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd; 
                case 'TwPa'
                    obj.Tw=x1;
                    obj.Pa=x2;
                    obj.d=obj.CaldByPa;
                    obj.Ta=obj.CalTaBydTw;
                    obj.Pws=obj.CalPws;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;
                case 'PwsPa'
                    obj.Pws=x1;
                    obj.Pa=x2;
                    obj.Ta=obj.CalTaByPws;
                    obj.d=obj.CaldByPa;
                    obj.Tw=obj.CalTwByTad;
                    obj.RH=obj.CalRHByPaPws;
                    obj.h=obj.CalhByTad;
                    obj.rou=obj.CalrouByTad;
                    obj.Td=obj.CalTd;
            end
        end
        function Pws=CalPws(obj)
            Pws=Cal.CalPws(obj.Ta);
        end
        function Pws=CalPwsByRHPa(obj)
            Pws=Cal.CalPwsByRHPa(obj.RH,obj.Pa);
        end
        function Pa=CalPaByRH(obj)
            Pa=Cal.CalPaByRH(obj.RH,obj.Pws);
        end
        function Pa=CalPaByd(obj)
            Pa=Cal.CalPaByd(obj.d,obj.B);
        end
        function d=CaldByPa(obj)
            d=Cal.CaldByPa(obj.Pa,obj.B);
        end
        function d=CaldByTaTw(obj)
            d=Cal.CaldByTaTw(obj.Ta,obj.Tw,obj.B);
        end
        function d=CaldByTah(obj)
            d=Cal.CaldByTah(obj.Ta,obj.h);
        end
        function d=CaldByTd(obj)
            d=Cal.CaldByTd(obj.Td,obj.B);
        end
        function d=CaldByTarou(obj)
            d=Cal.CaldByTarou(obj.Ta,obj.rou,obj.B);
        end
        function RH=CalRHByPaPws(obj)
            RH=Cal.CalRHByPaPws(obj.Pa,obj.Pws);
        end
        function h=CalhByTad(obj)
            h=Cal.CalhByTad(obj.Ta,obj.d);
        end
        function rou =CalrouByTad(obj)
            rou =Cal.CalrouByTad(obj.Ta,obj.d,obj.B);
        end
        function Td=CalTd(obj)
            Td = Cal.CalTd(obj.Pa);
        end    
        function Tw=CalTwByTad(obj)
            Tw=Cal.CalTwByTad(obj.Ta,obj.d,obj.B);
        end
        function Ta=CalTaByRHd(obj)
            Ta=Cal.CalTaByRHd(obj.RH,obj.d,obj.B);
        end
        function Ta=CalTaByRHh(obj)
            Ta=Cal.CalTaByRHh(obj.RH,obj.h,obj.B);
        end
        function Ta=CalTaByRHTw(obj)
        Ta=Cal.CalTaByRHTw(obj.RH,obj.Tw,obj.B);
        end
        function Ta=CalTaByPws(obj)
            Ta=Cal.CalTaByPws(obj.Pws);
        end
        function Ta=CalTaByRHrou(obj)
            Ta=Cal.CalTaByRHrou(obj.RH,obj.rou,obj.B);
        end
        function Ta=CalTaBydh(obj)
            Ta=Cal.CalTaBydh(obj.d,obj.h);
        end
        function Ta=CalTaBydTw(obj)
            Ta=Cal.CalTaBydTw(obj.d,obj.Tw,obj.B);
        end
        function Ta=CalTaBydrou(obj)
            Ta=Cal.CalTaBydrou(obj.d,obj.rou,obj.B);
        end
        function Ta=CalTaByhTw(obj)
            Ta=Cal.CalTaByhTw(obj.h,obj.Tw,obj.B);
        end
        function Ta=CalTaByhrou(obj)
            Ta=Cal.CalTaByhrou(obj.h,obj.rou,obj.B);
        end
        
    end
    
end


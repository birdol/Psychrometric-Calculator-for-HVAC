classdef idDiag
    %UNTITLED2 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        Type=0;
        B=101325;
        dmax;
        dd;
        tmin;
        dt;
        tmax;
        gradc=(41/6.5)/(50/16.5)/1.006;
        grade=(30/9.5)/(50/13.4/1.006);
    end
    methods
        function obj=idDiag(tmin,tmax,dt,dmax,dd,type,B)
            if nargin==7
                obj.B=B;
            end
            if nargin==6
                obj.Type=type;
            end
            obj.dmax=dmax;
            obj.dd=dd;
            obj.tmin=tmin;
            obj.dt=dt;
            obj.tmax=tmax;
        end
        function Drawid(obj)
            %画焓湿图
            set(gcf,'position',[200,100,700,700],'color','w')%窗口定位
            if obj.Type==0
                y=0.8*1.006*(obj.tmax-obj.tmin)/(obj.dmax*obj.gradc);
                ypos=(1-0.05-y)/2;
                set(gca,'position',[0.1,ypos,0.8,y],'XAxisLocation','top','color','w','xtick',0:obj.dd:obj.dmax,'ytick',obj.tmin:obj.dt:obj.tmax,'FontSize',14,'FontName','微软雅黑','xcolor','k','ycolor','k')%画布定位
                axis([0 obj.dmax obj.tmin obj.tmax]);%坐标轴
                hold on;
                tilname=['(B=',num2str(obj.B),'Pa)'];
                title(tilname,'FontSize',14,'FontName','微软雅黑','color','k');
                xlabel('含湿量(g/kg)','FontSize',14,'FontName','微软雅黑','color','k');
                ylabel('干球温度(℃)','FontSize',14,'FontName','微软雅黑','color','k');
                
                
            else
                y=0.8*obj.dmax/(1.006*(obj.tmax-obj.tmin)*obj.grade);
                ypos=(1-0.1-y)/2;
                set(gca,'position',[0.05,ypos,0.8,y],'YAxisLocation','right','color','w','ytick',0:obj.dd:obj.dmax,'xtick',obj.tmin:obj.dt:obj.tmax,'FontSize',14,'FontName','Times New Roman','xcolor','k','ycolor','k')%画布定位
                axis([obj.tmin obj.tmax 0 obj.dmax]);%坐标轴
                hold on;
                tilname=['(B=',num2str(obj.B),'Pa)'];
                title(tilname,'FontSize',14,'FontName','Times New Roman','color','k');
                ylabel('Humidity Ratio(g/kg)','FontSize',14,'FontName','Times New Roman','color','k');
                xlabel('Dry Bulb Temperature(℃)','FontSize',14,'FontName','Times New Roman','color','k');
                
                
            end
            hmin=ceil(obj.tmin*1.006);
            for k=hmin:2:200
                obj.hline(k);
            end
            for k=obj.tmin:2:obj.tmax
                obj.tline(k);
            end
            for k=0:1:obj.dmax
                obj.dline(k);
            end
            for k=100:-10:10
                obj.RHline(k);
            end
        end
        function y=Caly(obj,h,d)
            if obj.Type==0
                y=h/1.006-d*obj.gradc;
            else
                y=h/1.006-d*2.5;
            end
        end
        function hline(obj,h)
            y1=h/1.006;
            Ta=Cal.CalTaByRHh(100,h,obj.B);
            ds=Cal.CaldByPa(Cal.CalPws(Ta),obj.B);
            y2=obj.Caly(h,ds);
            if obj.Type==0
                plot([0 ds],[y1 y2],'b');
            else
                plot([y1 y2],[0 ds],'b');
            end
        end%等焓线
        function tline(obj,t)
            y1=t;
            ds=Cal.CaldByPa(Cal.CalPws(t),obj.B);
            h=Cal.CalhByTad(t,ds);
            y2=obj.Caly(h,ds);
            if obj.Type==0
                plot([0 ds],[y1 y2],'r');
            else
                plot([y1 y2],[0 ds],'r');
            end
        end%等温线
        function dline(obj,d)
            y1=obj.tmax;
            h=Cal.CalhByTad(Cal.CalTd(Cal.CalPaByd(d,obj.B)),d);
            y2=obj.Caly(h,d);
            if obj.Type==0
                plot([d d],[y1 y2],'g');
            else
                plot([y1 y2],[d d],'g');
            end
            
        end%等含湿量线
        function RHline(obj,RH)
            N=floor(obj.dmax/0.25);
            X=zeros(N,1);
            Y=zeros(N,1);
            d=obj.dmax;
            for k=1:N
                X(k)=d;
                h=Cal.CalhByTad(Cal.CalTaByRHd(RH,d,obj.B),d);
                Y(k)=obj.Caly(h,d);
                d=d-0.25;
            end
            
            if obj.Type==0
                if RH==100
                    plot(X,Y,'k','lineWidth',1.5);
                else
                    plot(X,Y,'k');
                end
            else
                if RH==100
                    plot(Y,X,'k','lineWidth',1.5);
                else
                    plot(Y,X,'k');
                end
            end
        end%等相对湿度线
        function drawPoints(obj,A)
            N=size(A,1);
            for k=1:N
                Ta=A(k,1);
                d=Cal.CaldByPa(Cal.CalPaByRH(A(k,2),Cal.CalPws(Ta)),obj.B);
                h=Cal.CalhByTad(Ta,d);
                y=obj.Caly(h,d);
                if obj.Type==0
                    plot(d,y,'r*','MarkerSize',10);
                else
                    plot(y,d,'r*','MarkerSize',10);
                end
            end
        end
    end
    
end



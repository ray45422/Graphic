namespace "ray"{
	class "smirnoff"{
		metamethod "_init"
		:body(
			function(self,width,height,name)
				self.width=width
				self.height=height
				self.wndNum=CreateWindow(width,height,name)
				self.penData={}
				self.brushData={}
				self.fontData={}
			end
		);
		
		method "MakeWindow"
		:body(
			function(self,width,height,name)
				--[[継承した時_initが使えなくて適当に作った;中身は_initと全く同じ;]]
				self.width=width
				self.height=height
				self.wndNum=CreateWindow(width,height,name)
				self.penData={}
				self.brushData={}
				self.fontData={}
			end
		);
		
		method "GetState"
		:body(
			function(self)
				return GetWindowState(self.wndNum)
			end
		);
		
		method "Move"
		:body(
			function(self,x,y)
				MoveWindow(self.wndNum,x,y)
			end
		);
		
		method "GetPos"
		:body(
			function(self)
				return GetWindowPos(self.wndNum)
			end
		);
		
		method "Resize"
		:body(
			function(self,width,height)
				ResizeWindow(self.wndNum,width,height)
			end
		);
		
		method "GetSize"
		:body(
			function(self)
				return GetWindowSize(self.wndNum)
			end
		);
		
		method "IsActive"
		:body(
			function(self)
				return IsWindowActive(self.wndNum)
			end
		);
		
		method "Activate"
		:body(
			function(self)
				ActivateWindow(self.wndNum)
			end
		);
		
		method "GetMousePos"
		:body(
			function(self)
				return GetMousePosition(self.wndNum)
			end
		);
		
		method "setCol"
		:body(
			function(col)
				if type(col)=="string" then
					col=tonumber(col,16)
				end
				return col
			end
		);
		
		method "SetBGCol"
		:body(
			function(self,col)
				self.bgCol=CreateBrush(self.setCol(col),1)
			end
		);
		
		method "CreatePen"
		:body(
			function(self,id,col,width)
				width=width or 1
				self.penData[id]=CreatePen(self.setCol(col),width)
			end
		);
		method "SetPen"
		:body(
			function(self,id)
				self.pen=self.penData[id]
			end
		);
		
		method "CreateBrush"
		:body(
			function(self,id,col)
				self.brushData[id]=CreateBrush(self.setCol(col))
			end
		);
		method "SetBrush"
		:body(
			function(self,id)
				self.brush=self.brushData[id]
			end
		);
		
		method "CreateFont"
		:body(
			function(self,id,size,isBold)
				isBold=isBold or 0
				self.fontData[id]=CreateFont(size,isBold)
			end
		);
		method "SetFont"
		:body(
			function(self,id)
				self.font=self.fontData[id]
			end
		);
		
		method "tick"
		:body(
			function(self)
				if self.bgCol~=nil then
					SelectObject(self.wndNum,self.bgCol)
					FillRectangle(self.wndNum,0,0,self.width,self.height)
				end
			end
		);
		
		method "DrawText"
		:body(
			function(self,x,y,col,string)
				SelectObject(self.wndNum,self.font)
				DrawText(self.wndNum,x,y,self.setCol(col),string)
			end
		);
		
		method "DrawRectangle"
		:body(
			function(self,x,y,width,height)
				SelectObject(self.wndNum,self.pen)
				DrawRectangle(self.wndNum,x,y,width,height)
			end
		);
		
		method "FillRectangle"
		:body(
			function(self,x,y,width,height)
				SelectObject(self.wndNum,self.brush)
				FillRectangle(self.wndNum,x,y,width,height)
			end
		);
		
		method "RotRectangle"
		:body(
			function(self,x,y,width,height,rad)
				rad=rad or 0
				width=width/2
				height=height/2
				SelectObject(self.wndNum,self.pen)
				MoveTo(self.wndNum,x-width*math.cos(rad)+height*math.sin(rad),y-width*math.sin(rad)-height*math.cos(rad))
				LineTo(self.wndNum,x+width*math.cos(rad)+height*math.sin(rad),y+width*math.sin(rad)-height*math.cos(rad))
				LineTo(self.wndNum,x+width*math.cos(rad)-height*math.sin(rad),y+width*math.sin(rad)+height*math.cos(rad))
				LineTo(self.wndNum,x-width*math.cos(rad)-height*math.sin(rad),y-width*math.sin(rad)+height*math.cos(rad))
				LineTo(self.wndNum,x-width*math.cos(rad)+height*math.sin(rad),y-width*math.sin(rad)-height*math.cos(rad))
			end
		);
		
		method "DrawCircle"
		:body(
			function(self,x,y,r)
				SelectObject(self.wndNum,self.pen)
				MoveTo(self.wndNum,x+r,y)
				for i=0,360,5 do
					local rad=math.rad(i)
					LineTo(self.wndNum,x+r*math.cos(rad),y+r*math.sin(rad))
				end
			end
		);
		
		method "FillCircle"
		:body(
			function(self,x,y,r)
				SelectObject(self.wndNum,self.pen)
				for i=0,180 do
					local rad=math.rad(i)
					MoveTo(self.wndNum,x+r*math.cos(rad),y+r*math.sin(rad))
					LineTo(self.wndNum,x+r*math.cos(-rad),y+r*math.sin(-rad))
				end
			end
		);
		
		method "DrawPoint"
		:body(
			function(self,x,y)
				SelectObject(self.wndNum,self.pen)
				MoveTo(self.wndNum,x,y)
				LineTo(self.wndNum,x,y)
			end
		);
		
		method "MoveTo"
		:body(
			function(self,x,y)
				SelectObject(self.wndNum,self.pen)
				MoveTo(self.wndNum,x,y)
			end
		);
		
		method "LineTo"
		:body(
			function(self,x,y,col,width)
				SelectObject(self.wndNum,self.pen)
				LineTo(self.wndNum,x,y)
			end
		);
		
		method "Destroy"
		:body(
			function(self)
				DestroyWindow(self.wndNum)
				self={}
			end
		);
	};
};

namespace "ray"{
	class "Rader"
	:inherits(ray.smirnoff)
	{
		metamethod "_init"
		:attributes(override)
		:body(
			function(self,width,height)
				self:MakeWindow(width,height,"Rader")
				self:SetBGCol(0)
				self:CreatePen(1,"FF00",4)
				self:CreatePen(2,"FF00",1)
				self:CreateFont(1,5)
				self.fontCol=tonumber("FFFFFF",16)
				self.RangeMode=0
				self.Mode=0
				self.level=2
			end
		);
		method "SetCircleCol"
		:body(
			function(self,col)
				self:CreatePen(2,self.setCol(col),1)
			end
		);
		method "SetPointCol"
		:body(
			function(self,col)
				self:CreatePen(1,self.setCol(col),4)
			end
		);
		method "SetFontCol"
		:body(
			function(self,col)
				self.fontCol=self.setCol(col)
			end
		);
		
		method "SetMode"
		:body(
			function(self,v)
				self.Mode=v
			end
		);
		
		method "SetRangeMode"
		:body(
			function(self,v)
				self.RangeMode=v
			end
		);
		method "SetLevel"
		:body(
			function(self,v)
				self.level=v
			end
		);
		method "tick"
		:attributes(override)
		:body(
			function(self,v)
				if self.bgCol~=nil then
					SelectObject(self.wndNum,self.bgCol)
					FillRectangle(self.wndNum,0,0,self.width,self.height)
				end
				local w=self.width/2
				local h=self.height/2
				local z,f
				if self.RangeMode==0 then
					f=LEN(p_table[v].lenx,p_table[v].lenz)
					z=math.floor(f/200+1)*100
				elseif self.RangeMode==1 then
					f=p_table.farther2
					z=math.floor(f/200+1)*100
				elseif self.RangeMode==2 then
					f=v
					z=math.floor(f/200)*100
				end
				out(23,f)
				local m=math.min(math.min(w,h)*0.9/f,1)
				local ay=_AY()
				self:SetPen(2)
				if self.Mode==0 then
					self:MoveTo(w-5,h+5)
					self:LineTo(w,h)
					self:LineTo(w+6,h+6)
				else
					self:MoveTo(w+5*(math.cos(ay)-math.sin(ay)),h+5*(math.cos(ay)+math.sin(ay)))
					self:LineTo(w,h)
					self:LineTo(w-6*(math.cos(ay)+math.sin(ay)),h+6*(math.cos(ay)-math.sin(ay)))
				end
				for i=1,3 do
					self:DrawCircle(w,h,z*i*m)
					if z>0 and self.level>1then
						self:DrawText(w,h+z*i*m,self.fontCol,z*i.."m")
					end
				end
				for i=0,_PLAYERS()-1 do
					if i~=hikeolib.netown() then
						self:SetPen(1)
						local x,y
						if self.Mode==0 then
							x=p_table[i].lenx*math.cos(ay)-p_table[i].lenz*math.sin(ay)
							y=p_table[i].lenz*math.cos(ay)+p_table[i].lenx*math.sin(ay)
						else
							x=p_table[i].lenx
							y=p_table[i].lenz
						end
						self:DrawPoint(w-x*m,h+y*m)
						if self.level>0 then
							self:DrawText(w-x*m-10,h+y*m-18,self.fontCol,_PLAYERNAME(i))
						end
						if self.level>2 then
							self:DrawText(w-x*m-20,h+y*m+5,self.fontCol,string.format("Alt:%d",p_table[i].y))
						end
						self:SetPen(2)
						for ii=1,29 do
							local lx=p_table[i].old_x[ii]-_X()
							local lz=p_table[i].old_z[ii]-_Z()
							local x,y
							if self.Mode==0 then
								x=lx*math.cos(ay)-lz*math.sin(ay)
								y=lz*math.cos(ay)+lx*math.sin(ay)
							else
								x=lx
								y=lz
							end
							self:LineTo(w-x*m,h+y*m)
						end
					end
				end
				return self.fontCol
			end
		);
	};
};


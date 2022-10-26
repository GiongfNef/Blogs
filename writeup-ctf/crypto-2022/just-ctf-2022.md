---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# just CTF 2022

### Simply Powered

![](<../../.gitbook/assets/image (19) (2) (1).png>)

From round 1-50 that is matrix 2x2 , 50-75 is 3x3, 75 - 98 is 11x11. So write the code to correspond case

```
from sage.all import *
from pwn import * 
from Crypto.Util.number import *
connect= remote("simply-powered-nyc3.nc.jctf.pro", 4444) 
connect.recvline()
for i in range(100):
    num = connect.recvline()
    print(num)
    if(int(num[5:7]) < 50):
        e = int(connect.recvline()[5:])
        p = int(connect.recvline()[5:])
        
        connect.recvline()
        m = connect.recvline().decode()
        
        a,b,c,d = m.split()
        tmp1 = []
        for i in a:
            if i.isdigit():
                tmp1.append(i)
        a = int(''.join(tmp1))
       

        tmp2 = []
        for i in b:
            if i.isdigit():
                tmp2.append(i)
        b = int(''.join(tmp2))
       

        tmp3 = []
        for i in c:
            if i.isdigit():
                tmp3.append(i)
        c = int(''.join(tmp3))

        tmp4 = []
        for i in d:
            if i.isdigit():
                tmp4.append(i)
        d = int(''.join(tmp4))

        mat = matrix(GF(p),[[a,b],[c,d]])
        order = mat.multiplicative_order()
        inver = inverse(e,order)
        result = (mat**inver )% p
        s = 0
        for i in result:
            for j in i:
                s+= int(j)
        
        connect.recvline()
        connect.sendline(str(s))
    elif (int(num[5:7]) < 75):
        print(num)
        e = int(connect.recvline()[5:])
        p = int(connect.recvline()[5:])
        
        connect.recvline()
        m = connect.recvline().decode()
        print(m)
        a1,a2,a3,a4,a5,a6,a7,a8,a9= m.split()
        tmp1 = []
        for i in a1:
            if i.isdigit():
                tmp1.append(i)
        a1 = int(''.join(tmp1))
       

        tmp2 = []
        for i in a2:
            if i.isdigit():
                tmp2.append(i)
        a2 = int(''.join(tmp2))
       

        tmp3 = []
        for i in a3:
            if i.isdigit():
                tmp3.append(i)
        a3 = int(''.join(tmp3))

        tmp4 = []
        for i in a4:
            if i.isdigit():
                tmp4.append(i)
        a4 = int(''.join(tmp4))
        tmp5 = []
        for i in a5:
            if i.isdigit():
                tmp5.append(i)
        a5 = int(''.join(tmp5))
        tmp6 = []
        for i in a6:
            if i.isdigit():
                tmp6.append(i)
        a6 = int(''.join(tmp6))
        tmp7 = []
        for i in a7:
            if i.isdigit():
                tmp7.append(i)
        a7 = int(''.join(tmp7))
        tmp8 = []
        for i in a8:
            if i.isdigit():
                tmp8.append(i)
        a8 = int(''.join(tmp8))
        tmp9 = []
        for i in a9:
            if i.isdigit():
                tmp9.append(i)
        a9 = int(''.join(tmp9))

        mat = matrix(GF(p),[[a1,a2,a3],[a4,a5,a6],[a7,a8,a9]])
        order = mat.multiplicative_order()
        inver = inverse(e,order)
        result = (mat**inver )% p
        s = 0
        for i in result:
            for j in i:
                s+= int(j)
        
        connect.recvline()
        connect.sendline(str(s))
    elif(int(num[5:7])<98):
        print(num)
        e = int(connect.recvline()[5:])
        p = int(connect.recvline()[5:])
        
        connect.recvline()
        m = connect.recvline().decode()
        print(m)
        a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42,a43,a44,a45,a46,a47,a48,a49= m.split()
        tmp1 = []
        for i in a1:
            if i.isdigit():
                tmp1.append(i)
        a1 = int(''.join(tmp1))
       

        tmp2 = []
        for i in a2:
            if i.isdigit():
                tmp2.append(i)
        a2 = int(''.join(tmp2))
       

        tmp3 = []
        for i in a3:
            if i.isdigit():
                tmp3.append(i)
        a3 = int(''.join(tmp3))

        tmp4 = []
        for i in a4:
            if i.isdigit():
                tmp4.append(i)
        a4 = int(''.join(tmp4))
        tmp5 = []
        for i in a5:
            if i.isdigit():
                tmp5.append(i)
        a5 = int(''.join(tmp5))
        tmp6 = []
        for i in a6:
            if i.isdigit():
                tmp6.append(i)
        a6 = int(''.join(tmp6))
        tmp7 = []
        for i in a7:
            if i.isdigit():
                tmp7.append(i)
        a7 = int(''.join(tmp7))
        tmp8 = []
        for i in a8:
            if i.isdigit():
                tmp8.append(i)
        a8 = int(''.join(tmp8))
        tmp9 = []
        for i in a9:
            if i.isdigit():
                tmp9.append(i)
        a9 = int(''.join(tmp9))
        #10
        tmp10 = []
        for i in a10:
            if i.isdigit():
                tmp10.append(i)
        a10 = int(''.join(tmp10))
       

        tmp11 = []
        for i in a11:
            if i.isdigit():
                tmp11.append(i)
        a11 = int(''.join(tmp11))
       

        tmp12 = []
        for i in a12:
            if i.isdigit():
                tmp12.append(i)
        a12 = int(''.join(tmp12))

        tmp13 = []
        for i in a13:
            if i.isdigit():
                tmp13.append(i)
        a13 = int(''.join(tmp13))

        tmp14 = []
        for i in a14:
            if i.isdigit():
                tmp14.append(i)
        a14 = int(''.join(tmp14))

        tmp15 = []
        for i in a15:
            if i.isdigit():
                tmp15.append(i)
        a15 = int(''.join(tmp15))

        tmp16 = []
        for i in a16:
            if i.isdigit():
                tmp16.append(i)
        a16 = int(''.join(tmp16))

        tmp17 = []
        for i in a17:
            if i.isdigit():
                tmp17.append(i)
        a17 = int(''.join(tmp17))

        tmp18 = []
        for i in a18:
            if i.isdigit():
                tmp18.append(i)
        a18 = int(''.join(tmp18))

        #10
        tmp19 = []
        for i in a19:
            if i.isdigit():
                tmp19.append(i)
        a19 = int(''.join(tmp19))
       

        tmp20 = []
        for i in a20:
            if i.isdigit():
                tmp20.append(i)
        a20 = int(''.join(tmp20))
       

        tmp21 = []
        for i in a21:
            if i.isdigit():
                tmp21.append(i)
        a21 = int(''.join(tmp21))

        tmp22= []
        for i in a22:
            if i.isdigit():
                tmp22.append(i)
        a22 = int(''.join(tmp22))
        tmp23 = []
        for i in a23:
            if i.isdigit():
                tmp23.append(i)
        a23 = int(''.join(tmp23))
        tmp24 = []
        for i in a24:
            if i.isdigit():
                tmp24.append(i)
        a24 = int(''.join(tmp24))
        tmp25 = []
        for i in a25:
            if i.isdigit():
                tmp25.append(i)
        a25 = int(''.join(tmp25))
        tmp26 = []
        for i in a26:
            if i.isdigit():
                tmp26.append(i)
        a26 = int(''.join(tmp26))
        tmp27 = []
        for i in a27:
            if i.isdigit():
                tmp27.append(i)
        a27 = int(''.join(tmp27))
        #10
        tmp28 = []
        for i in a28:
            if i.isdigit():
                tmp28.append(i)
        a28 = int(''.join(tmp28))
       

        tmp29 = []
        for i in a29:
            if i.isdigit():
                tmp29.append(i)
        a29 = int(''.join(tmp29))
       

        tmp30 = []
        for i in a30:
            if i.isdigit():
                tmp30.append(i)
        a30 = int(''.join(tmp30))

        tmp31 = []
        for i in a31:
            if i.isdigit():
                tmp31.append(i)
        a31 = int(''.join(tmp31))
        tmp32 = []
        for i in a32:
            if i.isdigit():
                tmp32.append(i)
        a32 = int(''.join(tmp32))
        tmp33 = []
        for i in a33:
            if i.isdigit():
                tmp33.append(i)
        a33 = int(''.join(tmp33))
        tmp34 = []
        for i in a34:
            if i.isdigit():
                tmp34.append(i)
        a34 = int(''.join(tmp34))
        tmp35 = []
        for i in a35:
            if i.isdigit():
                tmp35.append(i)
        a35 = int(''.join(tmp35))
        tmp36 = []
        for i in a36:
            if i.isdigit():
                tmp36.append(i)
        a36 = int(''.join(tmp36))
        #10
        tmp37 = []
        for i in a37:
            if i.isdigit():
                tmp37.append(i)
        a37 = int(''.join(tmp37))
       

        tmp38 = []
        for i in a38:
            if i.isdigit():
                tmp38.append(i)
        a38 = int(''.join(tmp38))
       

        tmp39 = []
        for i in a39:
            if i.isdigit():
                tmp39.append(i)
        a39 = int(''.join(tmp39))

        tmp40 = []
        for i in a40:
            if i.isdigit():
                tmp40.append(i)
        a40 = int(''.join(tmp40))
        tmp41 = []
        for i in a41:
            if i.isdigit():
                tmp41.append(i)
        a41 = int(''.join(tmp41))
        tmp42 = []
        for i in a42:
            if i.isdigit():
                tmp42.append(i)
        a42 = int(''.join(tmp42))
        tmp43 = []
        for i in a43:
            if i.isdigit():
                tmp43.append(i)
        a43 = int(''.join(tmp43))
        tmp44 = []
        for i in a44:
            if i.isdigit():
                tmp44.append(i)
        a44 = int(''.join(tmp44))
        tmp45 = []
        for i in a45:
            if i.isdigit():
                tmp45.append(i)
        a45 = int(''.join(tmp45))
        tmp46 = []
        for i in a46:
            if i.isdigit():
                tmp46.append(i)
        a46 = int(''.join(tmp46))
        tmp47 = []
        for i in a47:
            if i.isdigit():
                tmp47.append(i)
        a47 = int(''.join(tmp47))
        tmp48 = []
        for i in a48:
            if i.isdigit():
                tmp48.append(i)
        a48 = int(''.join(tmp48))
        tmp49 = []
        for i in a49:
            if i.isdigit():
                tmp49.append(i)
        a49 = int(''.join(tmp49))
        mat = matrix(GF(p),[[a1,a2,a3,a4,a5,a6,a7],[a8,a9,a10,a11,a12,a13,a14],[a15,a16,a17,a18,a19,a20,a21],[a22,a23,a24,a25,a26,a27,a28],[a29,a30,a31,a32,a33,a34,a35],[a36,a37,a38,a39,a40,a41,a42],[a43,a44,a45,a46,a47,a48,a49],])
        order = mat.multiplicative_order()
        inver = inverse(e,order)
        result = (mat**inver )% p
        s = 0
        for i in result:
            for j in i:
                s+= int(j)
        
        connect.recvline()
        connect.sendline(str(s))
    else:
        print(num)
        e = int(connect.recvline()[5:])
        p = int(connect.recvline()[5:])
        
        connect.recvline()
        m = connect.recvline().decode()
        print(m)
        a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, a32, a33, a34, a35, a36, a37, a38, a39, a40, a41, a42, a43, a44, a45, a46, a47, a48, a49, a50, a51, a52, a53, a54, a55, a56, a57, a58, a59, a60, a61, a62, a63, a64, a65, a66, a67, a68, a69, a70, a71, a72, a73, a74, a75, a76, a77, a78, a79, a80, a81, a82, a83, a84, a85, a86, a87, a88, a89, a90, a91, a92, a93, a94, a95, a96, a97, a98, a99, a100, a101, a102, a103, a104, a105, a106, a107, a108, a109, a110, a111, a112, a113, a114, a115, a116, a117, a118, a119, a120, a121= m.split()
        tmp1 = []
        for i in a1:
            if i.isdigit():
                tmp1.append(i)
        a1 = int(''.join(tmp1))
       

        tmp2 = []
        for i in a2:
            if i.isdigit():
                tmp2.append(i)
        a2 = int(''.join(tmp2))
       

        tmp3 = []
        for i in a3:
            if i.isdigit():
                tmp3.append(i)
        a3 = int(''.join(tmp3))

        tmp4 = []
        for i in a4:
            if i.isdigit():
                tmp4.append(i)
        a4 = int(''.join(tmp4))
        tmp5 = []
        for i in a5:
            if i.isdigit():
                tmp5.append(i)
        a5 = int(''.join(tmp5))
        tmp6 = []
        for i in a6:
            if i.isdigit():
                tmp6.append(i)
        a6 = int(''.join(tmp6))
        tmp7 = []
        for i in a7:
            if i.isdigit():
                tmp7.append(i)
        a7 = int(''.join(tmp7))
        tmp8 = []
        for i in a8:
            if i.isdigit():
                tmp8.append(i)
        a8 = int(''.join(tmp8))
        tmp9 = []
        for i in a9:
            if i.isdigit():
                tmp9.append(i)
        a9 = int(''.join(tmp9))
        #10
        tmp10 = []
        for i in a10:
            if i.isdigit():
                tmp10.append(i)
        a10 = int(''.join(tmp10))
       

        tmp11 = []
        for i in a11:
            if i.isdigit():
                tmp11.append(i)
        a11 = int(''.join(tmp11))
       

        tmp12 = []
        for i in a12:
            if i.isdigit():
                tmp12.append(i)
        a12 = int(''.join(tmp12))

        tmp13 = []
        for i in a13:
            if i.isdigit():
                tmp13.append(i)
        a13 = int(''.join(tmp13))

        tmp14 = []
        for i in a14:
            if i.isdigit():
                tmp14.append(i)
        a14 = int(''.join(tmp14))

        tmp15 = []
        for i in a15:
            if i.isdigit():
                tmp15.append(i)
        a15 = int(''.join(tmp15))

        tmp16 = []
        for i in a16:
            if i.isdigit():
                tmp16.append(i)
        a16 = int(''.join(tmp16))

        tmp17 = []
        for i in a17:
            if i.isdigit():
                tmp17.append(i)
        a17 = int(''.join(tmp17))

        tmp18 = []
        for i in a18:
            if i.isdigit():
                tmp18.append(i)
        a18 = int(''.join(tmp18))

        #10
        tmp19 = []
        for i in a19:
            if i.isdigit():
                tmp19.append(i)
        a19 = int(''.join(tmp19))
       

        tmp20 = []
        for i in a20:
            if i.isdigit():
                tmp20.append(i)
        a20 = int(''.join(tmp20))
       

        tmp21 = []
        for i in a21:
            if i.isdigit():
                tmp21.append(i)
        a21 = int(''.join(tmp21))

        tmp22= []
        for i in a22:
            if i.isdigit():
                tmp22.append(i)
        a22 = int(''.join(tmp22))
        tmp23 = []
        for i in a23:
            if i.isdigit():
                tmp23.append(i)
        a23 = int(''.join(tmp23))
        tmp24 = []
        for i in a24:
            if i.isdigit():
                tmp24.append(i)
        a24 = int(''.join(tmp24))
        tmp25 = []
        for i in a25:
            if i.isdigit():
                tmp25.append(i)
        a25 = int(''.join(tmp25))
        tmp26 = []
        for i in a26:
            if i.isdigit():
                tmp26.append(i)
        a26 = int(''.join(tmp26))
        tmp27 = []
        for i in a27:
            if i.isdigit():
                tmp27.append(i)
        a27 = int(''.join(tmp27))
        #10
        tmp28 = []
        for i in a28:
            if i.isdigit():
                tmp28.append(i)
        a28 = int(''.join(tmp28))
       

        tmp29 = []
        for i in a29:
            if i.isdigit():
                tmp29.append(i)
        a29 = int(''.join(tmp29))
       

        tmp30 = []
        for i in a30:
            if i.isdigit():
                tmp30.append(i)
        a30 = int(''.join(tmp30))

        tmp31 = []
        for i in a31:
            if i.isdigit():
                tmp31.append(i)
        a31 = int(''.join(tmp31))
        tmp32 = []
        for i in a32:
            if i.isdigit():
                tmp32.append(i)
        a32 = int(''.join(tmp32))
        tmp33 = []
        for i in a33:
            if i.isdigit():
                tmp33.append(i)
        a33 = int(''.join(tmp33))
        tmp34 = []
        for i in a34:
            if i.isdigit():
                tmp34.append(i)
        a34 = int(''.join(tmp34))
        tmp35 = []
        for i in a35:
            if i.isdigit():
                tmp35.append(i)
        a35 = int(''.join(tmp35))
        tmp36 = []
        for i in a36:
            if i.isdigit():
                tmp36.append(i)
        a36 = int(''.join(tmp36))
        #10
        tmp37 = []
        for i in a37:
            if i.isdigit():
                tmp37.append(i)
        a37 = int(''.join(tmp37))
       

        tmp38 = []
        for i in a38:
            if i.isdigit():
                tmp38.append(i)
        a38 = int(''.join(tmp38))
       

        tmp39 = []
        for i in a39:
            if i.isdigit():
                tmp39.append(i)
        a39 = int(''.join(tmp39))

        tmp40 = []
        for i in a40:
            if i.isdigit():
                tmp40.append(i)
        a40 = int(''.join(tmp40))
        tmp41 = []
        for i in a41:
            if i.isdigit():
                tmp41.append(i)
        a41 = int(''.join(tmp41))
        tmp42 = []
        for i in a42:
            if i.isdigit():
                tmp42.append(i)
        a42 = int(''.join(tmp42))
        tmp43 = []
        for i in a43:
            if i.isdigit():
                tmp43.append(i)
        a43 = int(''.join(tmp43))
        tmp44 = []
        for i in a44:
            if i.isdigit():
                tmp44.append(i)
        a44 = int(''.join(tmp44))
        tmp45 = []
        for i in a45:
            if i.isdigit():
                tmp45.append(i)
        a45 = int(''.join(tmp45))
        tmp46 = []
        for i in a46:
            if i.isdigit():
                tmp46.append(i)
        a46 = int(''.join(tmp46))
        tmp47 = []
        for i in a47:
            if i.isdigit():
                tmp47.append(i)
        a47 = int(''.join(tmp47))
        tmp48 = []
        for i in a48:
            if i.isdigit():
                tmp48.append(i)
        a48 = int(''.join(tmp48))
        tmp49 = []
        for i in a49:
            if i.isdigit():
                tmp49.append(i)
        a49 = int(''.join(tmp49))

        tmp50 = []
        for i in a50:
            if i.isdigit():
                tmp50.append(i)
        a50 = int(''.join(tmp50))
        tmp51 = []
        for i in a51:
            if i.isdigit():
                tmp51.append(i)
        a51 = int(''.join(tmp51))
        tmp52 = []
        for i in a52:
            if i.isdigit():
                tmp52.append(i)
        a52 = int(''.join(tmp52))

        tmp53 = []
        for i in a53:
            if i.isdigit():
                tmp53.append(i)
        a53 = int(''.join(tmp53))
        tmp54 = []
        for i in a54:
            if i.isdigit():
                tmp54.append(i)
        a54 = int(''.join(tmp54))
        tmp55 = []
        for i in a55:
            if i.isdigit():
                tmp55.append(i)
        a55 = int(''.join(tmp55))

        tmp56 = []
        for i in a56:
            if i.isdigit():
                tmp56.append(i)
        a56 = int(''.join(tmp56))
        tmp57 = []
        for i in a57:
            if i.isdigit():
                tmp57.append(i)
        a57 = int(''.join(tmp57))
        tmp58 = []
        for i in a58:
            if i.isdigit():
                tmp58.append(i)
        a58 = int(''.join(tmp58))
        tmp59 = []
        for i in a59:
            if i.isdigit():
                tmp59.append(i)
        a59 = int(''.join(tmp59))
        tmp60 = []
        for i in a60:
            if i.isdigit():
                tmp60.append(i)
        a60 = int(''.join(tmp60))
        tmp61 = []
        for i in a61:
            if i.isdigit():
                tmp61.append(i)
        a61 = int(''.join(tmp61))
        tmp62 = []
        for i in a62:
            if i.isdigit():
                tmp62.append(i)
        a62 = int(''.join(tmp62))
        tmp63 = []
        for i in a63:
            if i.isdigit():
                tmp63.append(i)
        a63 = int(''.join(tmp63))

        tmp64 = []
        for i in a64:
            if i.isdigit():
                tmp64.append(i)
        a64 = int(''.join(tmp64))
        tmp65 = []
        for i in a65:
            if i.isdigit():
                tmp65.append(i)
        a65 = int(''.join(tmp65))
        tmp66 = []
        for i in a66:
            if i.isdigit():
                tmp66.append(i)
        a66 = int(''.join(tmp66))
        tmp67 = []
        for i in a67:
            if i.isdigit():
                tmp67.append(i)
        a67 = int(''.join(tmp67))
        tmp68 = []
        for i in a68:
            if i.isdigit():
                tmp68.append(i)
        a68 = int(''.join(tmp68))

        tmp69 = []
        for i in a69:
            if i.isdigit():
                tmp69.append(i)
        a69 = int(''.join(tmp69))
        tmp70 = []
        for i in a70:
            if i.isdigit():
                tmp70.append(i)
        a70 = int(''.join(tmp70))
        tmp71 = []
        for i in a71:
            if i.isdigit():
                tmp71.append(i)
        a71 = int(''.join(tmp71))
        tmp72 = []
        for i in a72:
            if i.isdigit():
                tmp72.append(i)
        a72 = int(''.join(tmp72))
        tmp73 = []
        for i in a73:
            if i.isdigit():
                tmp73.append(i)
        a73 = int(''.join(tmp73))

        tmp74 = []
        for i in a74:
            if i.isdigit():
                tmp74.append(i)
        a74 = int(''.join(tmp74))
        tmp75 = []
        for i in a75:
            if i.isdigit():
                tmp75.append(i)
        a75 = int(''.join(tmp75))
        tmp76 = []
        for i in a76:
            if i.isdigit():
                tmp76.append(i)
        a76 = int(''.join(tmp76))
        tmp77 = []
        for i in a77:
            if i.isdigit():
                tmp77.append(i)
        a77 = int(''.join(tmp77))
        tmp78 = []
        for i in a78:
            if i.isdigit():
                tmp78.append(i)
        a78 = int(''.join(tmp78))
        tmp79 = []
        for i in a79:
            if i.isdigit():
                tmp79.append(i)
        a79 = int(''.join(tmp79))

        tmp80 = []
        for i in a80:
            if i.isdigit():
                tmp80.append(i)
        a80 = int(''.join(tmp80))
        tmp81 = []
        for i in a81:
            if i.isdigit():
                tmp81.append(i)
        a81 = int(''.join(tmp81))
        tmp82 = []
        for i in a82:
            if i.isdigit():
                tmp82.append(i)
        a82 = int(''.join(tmp82))
        tmp83 = []
        for i in a83:
            if i.isdigit():
                tmp83.append(i)
        a83 = int(''.join(tmp83))
        tmp84 = []
        for i in a84:
            if i.isdigit():
                tmp84.append(i)
        a84 = int(''.join(tmp84))
        tmp85 = []
        for i in a85:
            if i.isdigit():
                tmp85.append(i)
        a85 = int(''.join(tmp85))
        tmp86 = []
        for i in a86:
            if i.isdigit():
                tmp86.append(i)
        a86 = int(''.join(tmp86))
        tmp87 = []
        for i in a87:
            if i.isdigit():
                tmp87.append(i)
        a87 = int(''.join(tmp87))
        tmp88 = []
        for i in a88:
            if i.isdigit():
                tmp88.append(i)
        a88 = int(''.join(tmp88))
        tmp89 = []
        for i in a89:
            if i.isdigit():
                tmp89.append(i)
        a89 = int(''.join(tmp89))
        tmp90 = []
        for i in a90:
            if i.isdigit():
                tmp90.append(i)
        a90 = int(''.join(tmp90))

        tmp91 = []
        for i in a91:
            if i.isdigit():
                tmp91.append(i)
        a91 = int(''.join(tmp91))

        tmp92 = []
        for i in a92:
            if i.isdigit():
                tmp92.append(i)
        a92 = int(''.join(tmp92))

        tmp93 = []
        for i in a93:
            if i.isdigit():
                tmp93.append(i)
        a93 = int(''.join(tmp93))
        tmp94 = []
        for i in a94:
            if i.isdigit():
                tmp94.append(i)
        a94 = int(''.join(tmp94))
        tmp95 = []
        for i in a95:
            if i.isdigit():
                tmp95.append(i)
        a95 = int(''.join(tmp95))
        tmp96 = []
        for i in a96:
            if i.isdigit():
                tmp96.append(i)
        a96 = int(''.join(tmp96))
        tmp97 = []
        for i in a97:
            if i.isdigit():
                tmp97.append(i)
        a97 = int(''.join(tmp97))
        tmp98 = []
        for i in a98:
            if i.isdigit():
                tmp98.append(i)
        a98 = int(''.join(tmp98))
        tmp99 = []
        for i in a99:
            if i.isdigit():
                tmp99.append(i)
        a99 = int(''.join(tmp99))
        tmp100 = []
        for i in a100:
            if i.isdigit():
                tmp100.append(i)
        a100 = int(''.join(tmp100))
        tmp101 = []
        for i in a101:
            if i.isdigit():
                tmp101.append(i)
        a101 = int(''.join(tmp101))
        tmp102 = []
        for i in a102:
            if i.isdigit():
                tmp102.append(i)
        a102 = int(''.join(tmp102))
        tmp103 = []
        for i in a103:
            if i.isdigit():
                tmp103.append(i)
        a103 = int(''.join(tmp103))
        tmp104 = []
        for i in a104:
            if i.isdigit():
                tmp104.append(i)
        a104 = int(''.join(tmp104))
        tmp105 = []
        for i in a105:
            if i.isdigit():
                tmp105.append(i)
        a105 = int(''.join(tmp105))
        tmp106 = []
        for i in a106:
            if i.isdigit():
                tmp106.append(i)
        a106 = int(''.join(tmp106))

        tmp107 = []
        for i in a107:
            if i.isdigit():
                tmp107.append(i)
        a107 = int(''.join(tmp107))
        tmp108 = []
        for i in a108:
            if i.isdigit():
                tmp108.append(i)
        a108 = int(''.join(tmp108))
        tmp109 = []
        for i in a109:
            if i.isdigit():
                tmp109.append(i)
        a109 = int(''.join(tmp109))

        tmp110 = []
        for i in a110:
            if i.isdigit():
                tmp110.append(i)
        a110 = int(''.join(tmp110))
        tmp111 = []
        for i in a111:
            if i.isdigit():
                tmp111.append(i)
        a111 = int(''.join(tmp111))
        tmp112 = []
        for i in a112:
            if i.isdigit():
                tmp112.append(i)
        a112 = int(''.join(tmp112))
        tmp113 = []
        for i in a113:
            if i.isdigit():
                tmp113.append(i)
        a113 = int(''.join(tmp113))
        tmp114 = []
        for i in a114:
            if i.isdigit():
                tmp114.append(i)
        a114 = int(''.join(tmp114))
        tmp115 = []
        for i in a115:
            if i.isdigit():
                tmp115.append(i)
        a115 = int(''.join(tmp115))
        tmp116 = []
        for i in a116:
            if i.isdigit():
                tmp116.append(i)
        a116 = int(''.join(tmp116))
        tmp117 = []
        for i in a117:
            if i.isdigit():
                tmp117.append(i)
        a117 = int(''.join(tmp117))
        tmp118 = []
        for i in a118:
            if i.isdigit():
                tmp118.append(i)
        a118 = int(''.join(tmp118))

        tmp119 = []
        for i in a119:
            if i.isdigit():
                tmp119.append(i)
        a119 = int(''.join(tmp119))
        tmp120 = []
        for i in a120:
            if i.isdigit():
                tmp120.append(i)
        a120 = int(''.join(tmp120))
        tmp121 = []
        for i in a121:
            if i.isdigit():
                tmp121.append(i)
        a121 = int(''.join(tmp121))

        mat = matrix(GF(p),[[a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11],[a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22],[a23, a24, a25, a26, a27, a28, a29, a30, a31, a32, a33],
            [a34, a35, a36, a37, a38, a39, a40, a41, a42, a43, a44],[a45, a46, a47, a48, a49, a50, a51, a52, a53, a54, a55],
            [a56, a57, a58, a59, a60, a61, a62, a63, a64, a65, a66],[a67, a68, a69, a70, a71, a72, a73, a74, a75, a76, a77],
            [a78, a79, a80, a81, a82, a83, a84, a85, a86, a87, a88],[a89, a90, a91, a92, a93, a94, a95, a96, a97, a98, a99],
            [a100, a101, a102, a103, a104, a105, a106, a107, a108, a109, a110],[a111, a112, a113, a114, a115, a116, a117, a118, a119, a120, a121],])
        order = mat.multiplicative_order()
        inver = inverse(e,order)
        result = (mat**inver )% p
        s = 0
        for i in result:
            for j in i:
                s+= int(j)
        
        connect.recvline()
        connect.sendline(str(s))
```

Thanks for reading. Have a good day :heart: !


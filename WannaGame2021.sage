
import sys
import random
import socket
import threading
import socketserver
import signal
from ecdsa.ecdsa import generator_256
from flag import flag
	
class ThreadedTCPRequestHandler(socketserver.StreamRequestHandler):

	def handle(self):
		self.g = generator_256
		self.n = self.g.order()
		self.secret=random.randint(1,self.n)
		self.enc=self.g*self.secret
		try:
			self.welcome()
			for i in range(25):
				try:
					self.request.sendall(b'Give me your number:\n')
					number= int(self.rfile.readline().decode())
					tmp=self.g*(self.secret//number)
					self.request.sendall(b'x = '+str(tmp.x()).encode()+b'\n')
					self.request.sendall(b'y = '+str(tmp.y()).encode()+b'\n')
				except ValueError:
					self.request.sendall(
						b'Invalid!!!\n')
					continue
			self.request.sendall(b"Now can you find my secret?\n")
			check=int(self.rfile.readline().decode())
			if check==self.secret:
				self.get_flag()
			else:
				self.leak()
		except (ConnectionResetError, ConnectionAbortedError, BrokenPipeError):
			print("{} disconnected".format(self.client_address[0]))

	def welcome(self):
		self.request.sendall(b"If you can find my secret, i wil give you flag :D\n")
		self.request.sendall(b"First i will give you the encryption of the secret\n")
		self.request.sendall(b'Encrypted:\n')
		self.request.sendall(b'x = '+str(self.enc.x()).encode()+b'\n')
		self.request.sendall(b'y = '+str(self.enc.y()).encode()+b'\n')
		
	def get_flag(self):
		self.request.sendall(b"Yeah, you can find my secret. Your flag: "+flag+b'\n')
		
	def leak(self):
		self.request.sendall(b"My secret is: "+str(self.secret).encode()+b'\n')
class ThreadedTCPServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
	allow_reuse_address = True

if __name__=='__main__':
	host, port = '0.0.0.0', 5000
	server = ThreadedTCPServer((host, port), ThreadedTCPRequestHandler)
	server_thread = threading.Thread(target=server.serve_forever)
	server_thread.daemon = True
	server_thread.start()
	print("Start:", server_thread.name)
	server_thread.join()

SOLVE
====================================
from sock import Sock

a=-3
b=41058363725152142129326129780047268409114441015993725554835256314039467401291
p=115792089210356248762697446949407573530086143415290314195533631308867097853951
E=EllipticCurve(GF(p),[a,b])
c=Sock('45.122.249.68',10012)
print(c.recvuntil(b'Encrypted:\n'))
tmp=c.recvline()
print(tmp)
x=int(tmp[3:])
tmp=c.recvline()
print(tmp)
y=int(tmp[3:])
enc=E((x,y))
print(enc)
g=E((48439561293906451759052585252797914202762949526041747995844080717082404635286,36134250956749795798585127919587881956611106672985015071877198253568414405109))

primes=[1367, 1553, 1373, 1297, 1399, 1181, 1597, 1361, 1327, 1559, 1697, 1237, 1223, 1061, 1823, 1721, 1277, 1709, 1663, 1471, 2017, 1931, 1949, 1777, 1847]

n=prod(primes)
def recv(prime):
	c.recvuntil(b'Give me your number:\n')
	c.sendline(str(prime))
	tmp=c.recvline()
	x=int(tmp[4:])
	tmp=c.recvline()
	y=int(tmp[4:])
	return E((x,y))

def brute(g,x,Q):
	for i in range(x):
		if g*i==Q:
			return i
	return 0
tmp=[]
#Send 25 primes number and get result
for i in range(25):
	tmp.append(recv(primes[i]))
l=[]
#enc+(tmp[i]*-primes[i])<=> g*(x%primes[i])
for i in range(25):
	l.append(enc+(tmp[i]*-primes[i]))
result=[]
#Find x%primes[i]
for i in range(25):
	result.append(brute(g,primes[i],l[i]))
	print(result)
#recover secret
secret=crt(result,primes)
print(secret)
print(c.recvuntil(b"Now can you find my secret?\n"))
c.sendline(str(secret))
print(c.recvline())

============================================

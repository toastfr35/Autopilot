#ifndef _INTERFACES_HPP_
#define _INTERFACES_HPP_

class interfaces {
	public:
		virtual void read() = 0;
		virtual void write() = 0;
		virtual void reset() = 0;
};

#endif
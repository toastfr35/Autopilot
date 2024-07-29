#ifndef _INTERFACE_HPP_
#define _INTERFACE_HPP_

class interface {
	public:
		virtual void read() = 0;
		virtual void write() = 0;
		virtual void reset() = 0;
};

#endif
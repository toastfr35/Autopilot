#include <stdint.h>

#define MAP_SIZE 201

#pragma pack(push, 4)
typedef struct {
  int32_t ilat1;
  int32_t ilat2;
  int32_t ilon1;
  int32_t ilon2;
  uint32_t valid;
} t_request;

typedef struct {
  int32_t ilat1;
  int32_t ilat2;
  int32_t ilon1;
  int32_t ilon2;
  uint32_t valid;
  uint8_t data[MAP_SIZE];
} t_response;

typedef struct {
  double latitude;
  double longitude;
  float  elevation;
  bool   valid;
  t_request  requests[2];
  t_response response;
  uint16_t elevation_profile[MAP_SIZE/2];
} t_TMAP_status;

class t_iface_TMAP : interface {
	public :
		void read();
		void write();
		void reset();
		t_TMAP_status status;
};
#pragma pack(pop)


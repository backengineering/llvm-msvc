typedef float float4 __attribute__((ext_vector_type(4)));
typedef unsigned char vec __attribute__((ext_vector_type(16)));
typedef float float3 __attribute__((ext_vector_type(3)));

int main() {
    float4 f4 = {1.25, 1.25, 2.50, 2.50};
    vec v = (vec)f4;
    float3 f3 = f4.gba;
    return 0; // break here
}

// tensor.hpp

#include <cstdio>
#include <iostream>
#include <cstdarg>

template <typename Type>
class Tensor
{
  private:
    
    /********************** Private data members *********************/
    Type *_data;
    unsigned int *dims;
    unsigned int *stride;
    unsigned int rank;
    size_t total_elements;
    
    /******************** Private member functions *******************/
    // Error message for bad access
    template <typename A>
      void access_error(std::initializer_list<A> args)
    {
        typename std::initializer_list<A>::iterator it;
        
        printf("Error: Invalid access in Tensor:\n");
        printf("\t[");
        for (it=args.begin(); it<args.end()-1; ++it)
            printf("%d ",*it);
        printf("%d] is an invalid element in Tensor class object at %p\n",*(args.end()-1),this);
        printf("\twith dimensions [%u ",dims[0]);
        for (unsigned int r=1; r<rank-1; ++r)
            printf("%u ",dims[r]);
        printf("%u].\n",dims[rank-1]);
        abort();
    }
    
    // Error message for accessing out of bounds
    void bounds_error(size_t ind)
    {
        printf("Error: Invalid access in Tensor::at():\n");
        printf("\telement %lu is out of bounds in a list of size %lu\n",ind,total_elements);
        abort();
    }
    
    // Error message for provided number of dimensions exceeding rank
    void dim_error(int n)
    {
        printf("Number of dimensions exceeds specified tensor rank.\n");
        abort();
    }
    
    // Helper function to calculate index of requested element in _data
    template <typename A>
      inline unsigned int get_index(std::initializer_list<A> args)
    {
        unsigned int *str = stride;     // Local pointer to stride list
        unsigned int *dm = dims;        // Local pointer to dimensions list
        unsigned int ind = 0;           // Index of data to access
        
        // Loop through the array-initialized list and calculate the index
        typename std::initializer_list<A>::iterator li;
        for (li=args.begin(); li<args.end(); ++li, ++str, ++dm)
        {
            if (*li >= *dm) access_error(args); // Error if bad element
            ind += *li*(*str);
        }
        
        if (ind >= total_elements) bounds_error(ind);   // Error if out of bounds
        return ind;
    }
    
    // Error message for bad rank
    void rank_error(int n)
    {
        printf("Specified tensor rank exceeds number of dimensions provided.\n");
        abort();
    }
    
    
  public:
    
    /************************ Special members ************************/
    // Constructor
    Tensor(int _rank, ...): rank(_rank)
    {
        va_list ap;
        va_start(ap, _rank);
        
        unsigned int n = 0;     // Counter to check dims
        
        // Allocations
        dims = new unsigned int[_rank];
        stride = new unsigned int[_rank];
        total_elements = 1;
        for (int r=0; r<_rank; ++r, ++n)
        {
            int val = va_arg(ap,int);
            stride[r] = total_elements;
            total_elements *= val;
            dims[r] = val;
            
            if (n>=_rank) dim_error(n); // If looping past rank of tensor
        }
        if (n < _rank) rank_error(n);   // If insufficient rank
        va_end(ap);
        
        // Allocate the data buffer
        _data = new Type[total_elements];
    }
    
    // Copy constructor
    // seems std c++ does not allow templated copy constructors?
    
    // Destructor
    ~Tensor()
    {
        delete[] _data;
        delete[] dims;
        delete[] stride;
    }

    /******************** Public member functions ********************/
    // Rank 1 overload for efficiency
    Type at(int i)
    {
        return _data[i];
    }

    // Rank 2 overload for efficiency
    Type at(int i, int j)
    {
        unsigned int ind = i + stride[1]*j;
        return _data[ind];
    }
    
    // Rank 3 overload for efficiency
    Type at(int i, int j, int k)
    {
        if (i<dims[0] && (j<dims[1] && k<dims[2]))
        {
            unsigned int ind = i + stride[1]*j + stride[2]*k;
            return _data[ind];
        }
    }

    // General overload for arbitrary rank
    template <unsigned int R, typename A>
      Type& at(std::initializer_list<A> args)
    {
        return _data[get_index(args)];
    }
    
    // Set a specific element to some value
    template <typename A>
      void assign(std::initializer_list<A> args, Type val)
    {
        _data[get_index(args)] = val;
    }
};
// tensor.hpp

// The issues occur in TensorBlock

namespace __CXX_TENSOR_SUB
{
	struct TensorBlock
	{
	  private:
		// These are the member variables causing segfault
		void* block;
		std::vector<int> config;
		int myrank;
	
	  public:
		/*
		Allocate aims to create a space in memory for a new tensor
		*/
		void allocate(int _rank, int size, va_list* ap)
		{
			// This causes a segmentation fault
			myrank = _rank;
		
			int u = 1;
			for (int i = 0; i < _rank; i++)
			{
				// This causes a segmentation fault
				config.push_back(*va_arg((*ap), int));
				// This causes a segmentation fault
				u *= config[i];
			}
		
			printf("Allocating block of size %d\n", u * size);
			// This causes a segmentation fault
			block = malloc(u * size);
		}
		
		// Just freeing up tensor's memory space
		void destruct()
		{
			free(block);
		}
		
		// Not done this, haven't noticed any problems here yet
		void getIndex(void* rLoc, va_list* ap)
		{
			std::vector<int> index;
			for (int i = 0; i < myrank - 1; i++)
			{
				index.push_back(va_arg(ap, int));
			}
		
			int blockL = 0;
			int C = 1;
		
			for (int i = 0; i < myrank; i++)
			{
				blockL += index[i] * C;
				C *= config[i];
			}
		
			printf("Computed location in block to be %d\n", blockL);
		
			rLoc = block + blockL;
		}
	};
};

template <typename _Type>
class Tensor
{
  private:
	typedef _Type Type;
  
	__CXX_TENSOR_SUB::TensorBlock* block;
	
	
  public:
	Tensor(int _rank, ...)
	{
		printf("Allocating tensor space...\n");
		
		va_list ap;
		va_start(ap, &_rank);
		
		(*block).allocate(_rank, sizeof(Type), &ap);
		
		va_end(ap);
		
		printf("Successfully allocated tensor space!\n");
	}
	
	~Tensor()
	{
		printf("Freeing tensor space...\n");
		(*block).destruct();
		printf("Successfully freed tensor space!\n");
	}
	
	Type at(int index1, ...)
	{
		void* R;
		
		va_list ap;
		va_start(ap, (&index1) - 1);
		
		(*block).getIndex(R, &ap);
		
		va_end(ap);
		
		return *((Type*)(R));
	}
};
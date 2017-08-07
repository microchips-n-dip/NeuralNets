#ifndef EVN_SORT_H
#define EVN_SORT_H

// Sort and get fitnesses
template <typename Derived, typename Dimensions>
unsigned int partition(Derived& a, Dimensions& c, unsigned int p, unsigned int q)
{
	double c0 = c.at(p);
	unsigned int i = p;
	
	for (unsigned int j = p + 1; j < q; ++j) {
		if (c.at(j) <= c0) {
			std::swap(a.at(i), a.at(j));
			std::swap(c.at(i), c.at(j));
			++i;
		}
	}
	
	return i;
}

template <typename Derived, typename Dimensions>
void quick_sort(Derived& a, Dimensions& c, unsigned int p, unsigned int q)
{
	unsigned int r;
	
	if (p < q) {
		r = partition(a, c, p, q);
		quick_sort(a, c, p, r);
		quick_sort(a, c, r + 1, q);
	}
}

template <typename Derived>
void sort(Derived& a)
{
	std::vector<double> c;
	
	for (unsigned int i = 0; i < a.size(); ++i) {
		c.push_back(a.at(i)->net_fitness());
	}
	
	quick_sort(a, c, 0, a.size());
}

#endif

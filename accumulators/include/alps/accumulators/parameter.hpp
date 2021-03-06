/*
 * Copyright (C) 1998-2016 ALPS Collaboration. See COPYRIGHT.TXT
 * All rights reserved. Use is subject to license terms. See LICENSE.TXT
 * For use in publications, see ACKNOWLEDGE.TXT
 */

#ifndef ALPS_ACCUMULATOR_PARAMETER_HPP
#define ALPS_ACCUMULATOR_PARAMETER_HPP

#include <boost/parameter.hpp>

namespace alps {
    namespace accumulators {

        BOOST_PARAMETER_NAME((accumulator_name, accumulator_keywords) _accumulator_name)
        BOOST_PARAMETER_NAME((max_bin_number, accumulator_keywords) _max_bin_number)

    }
}
#endif

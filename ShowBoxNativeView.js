//  Created by react-native-create-bridge

import React, { Component } from 'react'
import { requireNativeComponent } from 'react-native'
import PropTypes from 'prop-types';



const ShowBox = requireNativeComponent('ShowBox', ShowBoxView)

export default class ShowBoxView extends Component {
  render () {
    return <ShowBox {...this.props} />
  }
}

ShowBoxView.propTypes = {
  exampleProp: PropTypes.string,
}

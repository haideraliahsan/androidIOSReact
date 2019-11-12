//  Created by react-native-create-bridge

import { NativeModules } from 'react-native'

const { ShowBox } = NativeModules

export default {
  exampleMethod () {
    return ShowBox.exampleMethod()
  },

  EXAMPLE_CONSTANT: ShowBox.EXAMPLE_CONSTANT
}

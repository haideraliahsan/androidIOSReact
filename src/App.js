import React from 'react';
import { View, Text, TouchableOpacity,Platform ,NativeModules} from 'react-native';
import ShowBox from '../ShowBoxNativeView'

class App extends React.Component {

    render() {
        console.disableYellowBox=true;
        return (
            <View style={{ flex: 1, justifyContent: 'center', alignContent: 'center' }}>
                <Text>
                    Prees Here to see Native UI
                </Text>
                <View style={{ justifyContent: 'center', alignContent: 'center', alignSelf: 'center', marginTop: 20 }}>
                    {Platform.OS=='android'
                    ?
                    <ShowBox exampleProp="Hassam" style={{ width: 120, height: 50 }} />
                    :
                    <TouchableOpacity onPress={()=>{
                            // Add object of native modules
                    }}>
                        <View style={{backgroundColor:'yellow'}}>
                        <Text style={{fontSize=20}}>
                            Run AR
                        </Text>
                        </View>
                       
                    </TouchableOpacity>
                    }
                </View>
            </View>
        )
    }
}
export default App;
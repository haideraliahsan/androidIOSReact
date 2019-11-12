//  Created by react-native-create-bridge

package com.bridgingdemo.showbox;

import android.content.Intent;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.bridgingdemo.UseArActivity;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

public class ShowBoxManager extends SimpleViewManager<View> {
    public static final String REACT_CLASS = "ShowBox";
    private ThemedReactContext mContext;
    private Button view;

    @Override
    public String getName() {
        // Tell React the name of the module
        // https://facebook.github.io/react-native/docs/native-components-android.html#1-create-the-viewmanager-subclass
        return REACT_CLASS;
    }

    @Override
    public View createViewInstance(ThemedReactContext context){
        // Create a view here
        // https://facebook.github.io/react-native/docs/native-components-android.html#2-implement-method-createviewinstance
        mContext=context;
        view=new Button(context);
        view.setText("Use AR ");
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(context, UseArActivity.class);
                context.startActivity(intent);
                Toast.makeText(context, "OK", Toast.LENGTH_SHORT).show();
            }
        });
        return view;
    }

    @ReactProp(name = "exampleProp")
    public void setExampleProp(View view, String prop) {

        // Set properties from React onto your native component via a setter method
        // https://facebook.github.io/react-native/docs/native-components-android.html#3-expose-view-property-setters-using-reactprop-or-reactpropgroup-annotation
    }
}

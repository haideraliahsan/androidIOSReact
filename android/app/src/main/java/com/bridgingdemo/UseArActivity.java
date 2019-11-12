package com.bridgingdemo;

import android.os.Bundle;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.google.ar.core.Anchor;
import com.google.ar.core.HitResult;
import com.google.ar.core.Plane;
import com.google.ar.sceneform.AnchorNode;
import com.google.ar.sceneform.rendering.ModelRenderable;
import com.google.ar.sceneform.rendering.ViewRenderable;
import com.google.ar.sceneform.ux.ArFragment;
import com.google.ar.sceneform.ux.BaseArFragment;
import com.google.ar.sceneform.ux.TransformableNode;

public class UseArActivity extends AppCompatActivity implements View.OnClickListener {
    ArFragment arFragment;
    private ModelRenderable beerRenderable,catRenderable;
    ImageView beer,cat;
    View arrayView[];
    ViewRenderable nameAnimal;

    int selectedid=1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_use_ar);

        arFragment= (ArFragment) getSupportFragmentManager().findFragmentById(R.id.sceneform_ux_fragment);



        beer=(ImageView) findViewById(R.id.beer);
        cat=(ImageView) findViewById(R.id.cat);

        serArrayView();
        setClickListner();
        setupModal();

        arFragment.setOnTapArPlaneListener(new BaseArFragment.OnTapArPlaneListener() {
            @Override
            public void onTapPlane(HitResult hitResult, Plane plane, MotionEvent motionEvent) {
                if(selectedid==1){
                    Anchor anchor=hitResult.createAnchor();
                    AnchorNode anchorNode= new AnchorNode(anchor);
                    anchorNode.setParent(arFragment.getArSceneView().getScene());

                    createModal(anchorNode, selectedid);
                }

            }
        });
    }

    private void setupModal() {

        ModelRenderable.builder()
                .setSource(this,R.raw.bear)
                .build().thenAccept(renderable -> beerRenderable= renderable)
                .exceptionally(
                        throwable -> {
                            Toast.makeText(this, "Unable to load beer", Toast.LENGTH_SHORT).show();
                            return null;
                        }
                );

        ModelRenderable.builder()
                .setSource(this,R.raw.cat)
                .build().thenAccept(renderable -> catRenderable= renderable)
                .exceptionally(
                        throwable -> {
                            Toast.makeText(this, "Unable to load cat", Toast.LENGTH_SHORT).show();
                            return null;
                        }
                );

    }

    private void createModal(AnchorNode anchorNode, int selectedid) {
        if(selectedid==1){
            TransformableNode bear = new TransformableNode(arFragment.getTransformationSystem());
            bear.setParent(anchorNode);
            bear.setRenderable(beerRenderable);
            bear.select();
        }
    }

    private void setClickListner() {
        for(int i=0; i<arrayView.length;i++){
            arrayView[i].setOnClickListener(this);
        }
    }

    private void serArrayView() {
        arrayView = new View[]{beer,cat};
    }

    @Override
    public void onClick(View view) {

    }
}

// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import org.bytedeco.javacpp.opencv_core;
import toxi.geom.*;
import org.openni.*;

Camera video;

void settings() {
    size(640, 480, P3D);
}

void setup() {
    selectInput("Select a video file to play:", "onFileSelected");
}

void onFileSelected(File selection) {
    if (selection == null) {
        exit();
    }
    else {
        playVideo(selection.getAbsolutePath());
    }
}

void playVideo(String videoFile) {
    try{
        video = CameraFactory.createCamera(Camera.Type.FFMPEG, videoFile);
        video.setParent(this);
        ((CameraFFMPEG)video).startVideo();
    } catch(CannotCreateCameraException cce){
        println("Cannot load the camera: " + cce);
    }
}

void draw() {
    if (video == null) return;
    video.grab();
    PImage im = video.getPImage();
    if (im != null) {
        image(im, 0, 0, width, height);
    }
}
